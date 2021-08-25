<#
    .SYNOPSIS
    Processes ScriptModel object
#>
param(
    [pscustomobject]$Script
)
process {
    $finalObject = @()
    if ($script.AdditionalData) {
        $sAddData = $script.AdditionalData | ConvertFrom-Json

        if ($sAddData.Params) {
            $allParamData = @()
            foreach ($p in $sAddData.Params) {
                $paramData = [Thycotic.PowerShell.Scripts.AdditionalDataParams]@{
                    Name    = $p.Name
                    SshType = $p.SshType
                }
                $allParamData += $paramData
            }
        }
        $additionalData = [Thycotic.PowerShell.Scripts.AdditionalData]@{
            Port                = $sAddData.Port
            LineEnding          = $sAddData.LineEnding
            Version             = $sAddData.Version
            DoNotUseEnvironment = $sAddData.DoNotUseEnvironment
            Params              = $allParamData
        }
    }
    $tssScript = [Thycotic.PowerShell.Scripts.Script]@{
        Active                   = $script.Active
        AdditionalData           = $additionalData
        ConcurrencyId            = $script.ConcurrencyId
        Description              = $script.Description
        Name                     = $script.Name
        OdbcConnectionStringArgs = $script.OdbcConnectionStringArgs
        ScriptContent            = $script.Script
        ScriptCategoryId         = $script.ScriptCategoryId
        ScriptCategoryName       = $script.ScriptCategoryName
        ScriptId                 = $script.ScriptId
        ScriptType               = $script.ScriptType
        UsageCount               = $script.UsageCount
    }
    $finalObject += $tssScript
    return $finalObject
}