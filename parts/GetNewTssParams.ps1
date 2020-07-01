<#
.Synopsis
    Gets New-TssSession's parameters
.Description
    Gets the parameters for New-TssSession from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in New-TssSession will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter,

    [Parameter(Mandatory,ParameterSetName = 'GetDynamicParameters')]
    [Alias('DynamicParameters')]
    [switch]
    $DynamicParameter
)

begin {
    if (-not ${script:New-TssSession}) {
        # If we haven't cached a reference to New-TssSession,
        ${script:New-TssSession} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('New-TssSession', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetDynamicParameters') {
        if (-not $script:InvokeTssRestApiParams) {
            $script:InvokeTssRestApiParams = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
            $InvokeTssRestApi = $executionContext.SessionState.InvokeCommand.GetCommand('New-TssSession', 'All')
            :nextInputParameter foreach ($in in ([Management.Automation.CommandMetaData]$InvokeTssRestApi).Parameters.Keys) {
                foreach ($ex in 'SecretServer','Credential','UseRefreshToken','RefreshLimit','AutoReconnect','Raw') {
                    if ($in -like $ex) { continue nextInputParameter }
                }

                $script:InvokeTssRestApiParams.Add($in, [Management.Automation.RuntimeDefinedParameter]::new(
                        $InvokeTssRestApi.Parameters[$in].Name,
                        $InvokeTssRestApi.Parameters[$in].ParameterType,
                        $InvokeTssRestApi.Parameters[$in].Attributes
                    ))
            }
            foreach ($paramName in $script:InvokeTssRestApiParams.Keys) {
                foreach ($attr in $script:InvokeTssRestApiParams[$paramName].Attributes) {
                    if ($attr.ValueFromPipeline) { $attr.ValueFromPipeline = $false }
                    if ($attr.ValueFromPipelineByPropertyName) { $attr.ValueFromPipelineByPropertyName = $false }
                }
            }
        }
        return $script:InvokeTssRestApiParams
    }
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $newTssParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($newTssParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in New-TssSession
            if (-not ${script:New-TssSession}.Parameters.ContainsKey($k)) {
                $newTssParams.Remove($k) # we remove it.
            }
        }
        return $newTssParams
    }

}