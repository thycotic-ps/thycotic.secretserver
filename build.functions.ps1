# Inlines src/functions into the staged module's psm1 so the released module imports one
# file instead of dot-sourcing 1,000+ (#486). Dot-sourced by build.ps1, build-release-only.ps1
# and tests/Module.FunctionInlining.Tests.ps1.

function Merge-ModuleFunction {
    <#
    .SYNOPSIS
    Replaces the Import Functions loader in a staged module's psm1 with the function files' content, then removes the functions folder.

    .DESCRIPTION
    Each function file must hold exactly one function named after the file and nothing else: no #requires, no using
    statements, no script-level param/begin/process blocks or other top-level code, and no $PSScriptRoot,
    $PSCommandPath or MyCommand.Path, which point at the psm1 once inlined. Any violation throws and leaves the
    staged module unchanged. The merged text is parsed once and checked as a whole, which is much faster than
    parsing each file.
    #>
    [CmdletBinding()]
    param(
        # Staged module folder holding Thycotic.SecretServer.psm1 and functions\
        [Parameter(Mandatory)]
        [string]
        $ModulePath
    )
    $psm1Path = [IO.Path]::Combine($ModulePath, 'Thycotic.SecretServer.psm1')
    $functionsPath = [IO.Path]::Combine($ModulePath, 'functions')

    # Same enumeration as the psm1 loader, so functions are defined in the same order.
    $files = @(Get-ChildItem -Path $functionsPath -Recurse -Filter *-*.ps1)
    if ($files.Count -eq 0) {
        throw "No function files found under $functionsPath"
    }

    $psm1 = [IO.File]::ReadAllText($psm1Path)
    $loader = [regex]::Matches($psm1, '(?s)#region Import Functions\r?\n.*?#endregion Import Functions')
    if ($loader.Count -ne 1) {
        throw "Expected one '#region Import Functions' block in $psm1Path, found $($loader.Count)"
    }
    $prefix = $psm1.Substring(0, $loader[0].Index)
    $suffix = $psm1.Substring($loader[0].Index + $loader[0].Length)

    # Build the inlined block and record the psm1 line range each file lands on.
    $newLine = [Environment]::NewLine
    $inlined = [System.Text.StringBuilder]::new()
    $line = [regex]::Matches($prefix, "`n").Count + 1
    [void]$inlined.Append("#region Import Functions (inlined by build.functions.ps1)$newLine")
    $line++
    $ranges = foreach ($file in $files) {
        $relativePath = $file.FullName.Substring($ModulePath.Length + 1).Replace('\', '/')
        $content = [IO.File]::ReadAllText($file.FullName).TrimEnd()
        [void]$inlined.Append("#region $relativePath$newLine")
        $line++
        $start = $line
        $line += [regex]::Matches($content, "`n").Count + 1
        [void]$inlined.Append("$content$newLine#endregion$newLine")
        [pscustomobject]@{ Path = $relativePath; Name = $file.BaseName; Start = $start; End = $line - 1; Content = $content }
        $line++
    }
    [void]$inlined.Append('#endregion Import Functions')
    $merged = $prefix + $inlined.ToString() + $suffix

    $starts = [int[]]@($ranges.Start)
    $firstLine = $ranges[0].Start
    $lastLine = $ranges[-1].End
    $rangeAt = {
        param([int]$LineNumber)
        $i = [Array]::BinarySearch($starts, $LineNumber)
        if ($i -lt 0) { $i = (-bnot $i) - 1 }
        if ($i -ge 0 -and $LineNumber -le $ranges[$i].End) { $ranges[$i] }
    }

    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseInput($merged, [ref]$null, [ref]$parseErrors)
    $problems = [System.Collections.Generic.List[string]]::new()
    foreach ($parseError in $parseErrors) {
        $range = & $rangeAt $parseError.Extent.StartLineNumber
        $where = if ($range) { $range.Path } else { "psm1 line $($parseError.Extent.StartLineNumber)" }
        $problems.Add("${where}: parse error: $($parseError.Message)")
    }
    if (-not $parseErrors) {
        if ($ast.ScriptRequirements) {
            foreach ($range in $ranges.Where({ $_.Content -match '(?im)^\s*#requires' })) { $problems.Add("$($range.Path): contains #requires") }
        }
        # The loader opens the psm1, so the first file's using statements or script blocks would parse
        # as the module's own; anywhere else they are parse errors.
        $scriptLevel = @($ast.UsingStatements) + @($ast.ParamBlock, $ast.DynamicParamBlock, $ast.BeginBlock, $ast.ProcessBlock)
        foreach ($node in $scriptLevel.Where({ $_ })) {
            $range = & $rangeAt $node.Extent.StartLineNumber
            if ($range) {
                $keyword = ($node.Extent.Text -split '[\s(]', 2)[0]
                $problems.Add("$($range.Path): script-level $keyword statement or block")
            }
        }
        $functionCount = @{}
        foreach ($statement in $ast.EndBlock.Statements) {
            $range = & $rangeAt $statement.Extent.StartLineNumber
            if (-not $range) { continue }
            if ($statement -isnot [System.Management.Automation.Language.FunctionDefinitionAst]) {
                $problems.Add("$($range.Path): top-level code besides the function")
            } elseif ($statement.Name -ne $range.Name) {
                $problems.Add("$($range.Path): function name [$($statement.Name)] does not match the file name")
            } else {
                $functionCount[$range.Path] = 1 + [int]$functionCount[$range.Path]
            }
        }
        foreach ($range in $ranges) {
            $count = [int]$functionCount[$range.Path]
            if ($count -ne 1) { $problems.Add("$($range.Path): must contain exactly one function named after the file (found $count)") }
        }
        $pathReferences = $ast.FindAll({
                param($node)
                $node.Extent.StartLineNumber -ge $firstLine -and $node.Extent.StartLineNumber -le $lastLine -and (
                    ($node -is [System.Management.Automation.Language.VariableExpressionAst] -and
                    $node.VariablePath.UserPath -in 'PSScriptRoot', 'PSCommandPath') -or
                    ($node -is [System.Management.Automation.Language.MemberExpressionAst] -and
                    $node.Member.Extent.Text -eq 'Path' -and $node.Expression.Extent.Text -like '*MyCommand'))
            }, $true)
        foreach ($node in $pathReferences) {
            $range = & $rangeAt $node.Extent.StartLineNumber
            $problems.Add("$($range.Path): uses $($node.Extent.Text), which points at the psm1 once inlined")
        }
    }
    if ($problems.Count -gt 0) {
        throw "Function files cannot be inlined:`n$($problems -join "`n")"
    }

    [IO.File]::WriteAllText($psm1Path, $merged, [System.Text.UTF8Encoding]::new($false))
    Remove-Item -Path $functionsPath -Recurse -Force
    Write-Output "Inlined $($files.Count) function files into $psm1Path"
}
