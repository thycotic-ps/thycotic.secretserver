<#
.Synopsis
    Gets Set-TssSecret's parameters based on parameter set
#>
param(
    [Parameter(Mandatory, Position = 0)]
    [string]
    $CommandName,

    [Parameter(Mandatory, Position = 1)]
    [string]
    $ParameterSetName
)

begin {
    $cmdDetails = [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($CommandName, 'Function')
}

process {
    $setSecretParamSetParams = @()
    $parameters = $cmdDetails.Parameters
    foreach ($k in @($cmdDetails.Parameters.Keys)) {
        if ($parameters[$k].ParameterSets[$ParameterSetName]) {
            $setSecretParamSetParams += $k
        }
    }
    return $setSecretParamSetParams
}