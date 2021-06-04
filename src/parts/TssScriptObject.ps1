<#
    .SYNOPSIS
    Processes ScriptModel object
#>
param(
    [pscustomobject]$Object
)
begin {
    $Properties = $Object.PSObject.Properties.Name
}
process {
    $finalObject = @()
    foreach ($script in $Object) {
        if ($script.AdditionalData) {
            $sAddData = $script.AdditionalData | ConvertFrom-Json

            if ($sAddData.Params) {
                $allParamData = @()
                foreach ($p in $sAddData.Params) {
                    $paramData = [TssScriptAdditionalDataParams]@{
                        Name = $p.Name
                        SshType = $p.SshType
                    }
                    $allParamData += $paramData
                }
            }
            $additionalData = [TssScriptAdditionalData]@{
                Port = $sAddData.Port
                LineEnding = $sAddData.LineEnding
                Version = $sAddData.Version
                DoNotUseEnvironment = $sAddData.DoNotUseEnvironment
                Params = $allParamData
            }
        }
        $tssScript = [TssScript]@{
            Active = $script.Active
            AdditionalData = $additionalData
            ConcurrencyId = $script.ConcurrencyId
            Description = $script.Description
            Name = $script.Name
            OdbcConnectionStringArgs = $script.OdbcConnectionStringArgs
            Script = $script.Script
            ScriptCategoryId = $script.ScriptCategoryId
            ScriptCategoryName = $script.ScriptCategoryName
            ScriptId = $script.ScriptId
            ScriptType = $script.ScriptType
            UsageCount = $script.UsageCount
        }

        $finalObject += $tssScript
    }
    return $finalObject
}