<#
.SYNOPSIS
    Generate per-type reference markdown for docs/types/ from C# source.

.DESCRIPTION
    Walks src/Thycotic.SecretServer/classes/ and src/Thycotic.SecretServer/enums/,
    parses each .cs file with simple regex (the files are POCOs/enums, no fancy
    C# features), and emits one Jekyll/just-the-docs page per type under
    docs/types/<category>/<TypeName>.md plus a readme.md index per category and
    a top-level docs/types/readme.md.

    Re-run to regenerate after C# changes.
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,
    [int]$NavOrder = 4
)

$ErrorActionPreference = 'Stop'
$classesRoot = Join-Path $RepoRoot 'src/Thycotic.SecretServer/classes'
$enumsRoot   = Join-Path $RepoRoot 'src/Thycotic.SecretServer/enums'
$docsRoot    = Join-Path $RepoRoot 'docs/types'

function ConvertTo-Title {
    param([string]$Kebab)
    ($Kebab -split '-' | ForEach-Object {
        if ($_.Length -eq 0) { return $_ }
        $_.Substring(0, 1).ToUpper() + $_.Substring(1)
    }) -join ' '
}

function Parse-ClassFile {
    param([string]$Path)

    $src = Get-Content -Raw -Path $Path
    $ns  = if ($src -match 'namespace\s+([\w\.]+)') { $Matches[1] } else { $null }

    $type = $null
    if ($src -match 'public\s+(class|enum)\s+(\w+)(?:\s*:\s*([\w\.,\s<>?]+?))?\s*\{') {
        $type = [pscustomobject]@{
            Kind      = $Matches[1]
            Name      = $Matches[2]
            BaseList  = if ($Matches[3]) { ($Matches[3].Trim() -split '\s*,\s*') } else { @() }
            FullName  = "$ns.$($Matches[2])"
            Namespace = $ns
        }
    }
    if (-not $type) { return $null }

    if ($type.Kind -eq 'enum') {
        $values = @()
        $body = if ($src -match '(?ms)enum\s+\w+[^{]*\{([^}]*)\}') { $Matches[1] } else { '' }
        foreach ($line in ($body -split '\r?\n')) {
            $stripped = $line -replace '//.*$', '' -replace '/\*.*?\*/', ''
            $stripped = $stripped.Trim().TrimEnd(',')
            if (-not $stripped) { continue }
            if ($stripped -match '^(\w+)\s*=\s*(.+)$') {
                $values += [pscustomobject]@{ Name = $Matches[1]; Value = $Matches[2].Trim() }
            } elseif ($stripped -match '^(\w+)$') {
                $values += [pscustomobject]@{ Name = $Matches[1]; Value = $null }
            }
        }
        return [pscustomobject]@{
            Kind = 'enum'; Type = $type; Values = $values
        }
    }

    # class — extract properties and methods
    $properties = @()
    foreach ($m in [regex]::Matches($src, 'public\s+(?<type>[\w\.\<\>\[\]\?\,\s]+?)\s+(?<name>\w+)\s*\{\s*(?<accessors>get;(?:\s*set;)?)\s*\}(?:\s*=\s*(?<default>[^;]+);)?')) {
        $accessors = $m.Groups['accessors'].Value -replace '\s+', ''
        $isReadonly = ($accessors -eq 'get;')
        $properties += [pscustomobject]@{
            Type     = ($m.Groups['type'].Value -replace '\s+', ' ').Trim()
            Name     = $m.Groups['name'].Value
            Readonly = $isReadonly
            Default  = if ($m.Groups['default'].Success) { $m.Groups['default'].Value.Trim() } else { $null }
        }
    }

    $methods = @()
    # signature only — body discarded
    foreach ($m in [regex]::Matches($src, '(?ms)public\s+(?!class\b|enum\b)(?<ret>[\w\.\<\>\[\]\?\,\s]+?)\s+(?<name>\w+)\s*\((?<args>[^\)]*)\)\s*\{')) {
        $ret = ($m.Groups['ret'].Value -replace '\s+', ' ').Trim()
        # exclude property accessors that the property regex didn't catch
        if ($ret -eq 'string' -or $ret -eq 'int' -or $ret -eq 'bool' -or $ret -eq 'void' -or $ret -match '^[A-Z]') {
            $methods += [pscustomobject]@{
                ReturnType = $ret
                Name       = $m.Groups['name'].Value
                Args       = $m.Groups['args'].Value.Trim()
            }
        }
    }
    # filter out the type's own constructor (same name as the type)
    $ctors  = $methods | Where-Object { $_.Name -eq $type.Name }
    $methods = $methods | Where-Object { $_.Name -ne $type.Name }

    return [pscustomobject]@{
        Kind = 'class'; Type = $type; Properties = $properties; Methods = $methods; Constructors = $ctors
    }
}

function Format-TypeMarkdown {
    param($Parsed, [string]$Category)

    $t = $Parsed.Type
    $title = $t.Name
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('---')
    [void]$sb.AppendLine("title: $title")
    [void]$sb.AppendLine("parent: $(ConvertTo-Title $Category)")
    [void]$sb.AppendLine("grand_parent: Types")
    [void]$sb.AppendLine('---')
    [void]$sb.AppendLine()
    [void]$sb.AppendLine("# $title")
    [void]$sb.AppendLine()
    [void]$sb.AppendLine("**Kind:** $($Parsed.Kind)  ")
    [void]$sb.AppendLine("**Full name:** ``$($t.FullName)``  ")
    [void]$sb.AppendLine("**Namespace:** ``$($t.Namespace)``  ")
    if ($t.BaseList.Count -gt 0) {
        [void]$sb.AppendLine("**Inherits / implements:** $($t.BaseList -join ', ')  ")
    }
    [void]$sb.AppendLine()

    if ($Parsed.Kind -eq 'enum') {
        [void]$sb.AppendLine("## Values")
        [void]$sb.AppendLine()
        [void]$sb.AppendLine('| Name | Value |')
        [void]$sb.AppendLine('|---|---|')
        foreach ($v in $Parsed.Values) {
            $val = if ($null -ne $v.Value) { "``$($v.Value)``" } else { '_(default)_' }
            [void]$sb.AppendLine("| ``$($v.Name)`` | $val |")
        }
        [void]$sb.AppendLine()
        return $sb.ToString()
    }

    if ($Parsed.Constructors.Count -gt 0) {
        [void]$sb.AppendLine("## Constructors")
        [void]$sb.AppendLine()
        foreach ($c in $Parsed.Constructors) {
            $argText = if ($c.Args) { $c.Args } else { '' }
            [void]$sb.AppendLine("- ``$($c.Name)($argText)``")
        }
        [void]$sb.AppendLine()
    } else {
        [void]$sb.AppendLine("## Constructors")
        [void]$sb.AppendLine()
        [void]$sb.AppendLine("- ``new()`` _(default)_")
        [void]$sb.AppendLine()
    }

    if ($Parsed.Properties.Count -gt 0) {
        [void]$sb.AppendLine("## Properties")
        [void]$sb.AppendLine()
        [void]$sb.AppendLine('| Name | Type | Access | Default |')
        [void]$sb.AppendLine('|---|---|---|---|')
        foreach ($p in ($Parsed.Properties | Sort-Object Name)) {
            $access = if ($p.Readonly) { 'readonly' } else { 'read/write' }
            $default = if ($p.Default) { "``$($p.Default)``" } else { '—' }
            [void]$sb.AppendLine("| ``$($p.Name)`` | ``$($p.Type)`` | $access | $default |")
        }
        [void]$sb.AppendLine()
    }

    if ($Parsed.Methods.Count -gt 0) {
        [void]$sb.AppendLine("## Methods")
        [void]$sb.AppendLine()
        foreach ($mm in ($Parsed.Methods | Sort-Object Name)) {
            $argText = if ($mm.Args) { $mm.Args } else { '' }
            [void]$sb.AppendLine("- ``[$($mm.ReturnType)] $($mm.Name)($argText)``")
        }
        [void]$sb.AppendLine()
    }

    return $sb.ToString()
}

function Write-CategoryIndex {
    param([string]$Path, [string]$Title, [string]$Parent, [int]$NavOrder = $null)

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('---')
    [void]$sb.AppendLine("title: $Title")
    if ($Parent) { [void]$sb.AppendLine("parent: $Parent") }
    if ($NavOrder) { [void]$sb.AppendLine("nav_order: $NavOrder") }
    [void]$sb.AppendLine("has_children: true")
    [void]$sb.AppendLine('---')
    [void]$sb.AppendLine()
    [void]$sb.AppendLine("# $Title")
    [void]$sb.AppendLine()
    [void]$sb.AppendLine("{% include list.liquid all=true %}")
    [void]$sb.AppendLine()
    Set-Content -Path $Path -Value $sb.ToString() -Encoding UTF8
}

# --- main ---

# Reset docs/types
if (Test-Path $docsRoot) {
    Remove-Item -Recurse -Force $docsRoot
}
New-Item -ItemType Directory -Force -Path $docsRoot | Out-Null

# Top-level index
$topIndex = Join-Path $docsRoot 'readme.md'
$sb = [System.Text.StringBuilder]::new()
[void]$sb.AppendLine('---')
[void]$sb.AppendLine('title: Types')
[void]$sb.AppendLine("nav_order: $NavOrder")
[void]$sb.AppendLine('has_children: true')
[void]$sb.AppendLine('---')
[void]$sb.AppendLine()
[void]$sb.AppendLine('# Types')
[void]$sb.AppendLine()
[void]$sb.AppendLine('Reference for the C# classes and enums exposed by the Thycotic.SecretServer module.')
[void]$sb.AppendLine('Each page lists the full type name, namespace, properties, methods, and (for enums) numeric values.')
[void]$sb.AppendLine('These pages are auto-generated from the C# source under `src/Thycotic.SecretServer/`.')
[void]$sb.AppendLine()
[void]$sb.AppendLine('{% include list.liquid all=true %}')
[void]$sb.AppendLine()
Set-Content -Path $topIndex -Value $sb.ToString() -Encoding UTF8

# Walk both classes/ and enums/ — combine into same per-category folder
$sourceRoots = @($classesRoot, $enumsRoot)
$parsedByCategory = @{}
$counts = @{ class = 0; enum = 0; skipped = 0 }

foreach ($root in $sourceRoots) {
    if (-not (Test-Path $root)) { continue }
    foreach ($file in Get-ChildItem -Path $root -Recurse -Filter *.cs) {
        $rel = $file.FullName.Substring($root.Length).TrimStart([char]'\', [char]'/')
        $parts = $rel -split '[\\/]'
        $category = if ($parts.Length -ge 2) { $parts[0] } else { 'common' }
        $parsed = Parse-ClassFile -Path $file.FullName
        if (-not $parsed) {
            Write-Warning "Could not parse $($file.FullName)"
            $counts.skipped++
            continue
        }
        if (-not $parsedByCategory.ContainsKey($category)) { $parsedByCategory[$category] = @() }
        $parsedByCategory[$category] += $parsed
        $counts[$parsed.Kind]++
    }
}

# Emit per-type pages + per-category index
$categories = $parsedByCategory.Keys | Sort-Object
foreach ($cat in $categories) {
    $catDir = Join-Path $docsRoot $cat
    New-Item -ItemType Directory -Force -Path $catDir | Out-Null

    $catTitle = ConvertTo-Title $cat
    Write-CategoryIndex -Path (Join-Path $catDir 'readme.md') -Title $catTitle -Parent 'Types'

    foreach ($parsed in ($parsedByCategory[$cat] | Sort-Object { $_.Type.Name })) {
        $md = Format-TypeMarkdown -Parsed $parsed -Category $cat
        $out = Join-Path $catDir "$($parsed.Type.Name).md"
        Set-Content -Path $out -Value $md -Encoding UTF8
    }
}

Write-Host ""
Write-Host "Generated $($counts.class) classes, $($counts.enum) enums, skipped $($counts.skipped) (categories: $($categories.Count))"
Write-Host "Output: $docsRoot"
