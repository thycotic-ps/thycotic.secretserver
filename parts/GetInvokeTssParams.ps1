<#
.Synopsis
    Gets Invoke-TssRestApi's parameters
.Description
    Gets the parameters for Invoke-TssRestApi from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Invoke-TssRestApi will be removed
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
    if (-not ${script:Invoke-RestApi}) {
        # If we haven't cached a reference to Invoke-TssRestApi,
        ${script:Invoke-RestApi} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Invoke-TssRestApi', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetDynamicParameters') {
        if (-not $script:InvokeTssRestApiParams) {
            $script:InvokeTssRestApiParams = [Management.Automation.RuntimeDefinedParameterDictionary]::new()
            $InvokeTssRestApi = $executionContext.SessionState.InvokeCommand.GetCommand('Invoke-TssRestApi', 'All')
            :nextInputParameter foreach ($in in ([Management.Automation.CommandMetaData]$InvokeTssRestApi).Parameters.Keys) {
                foreach ($ex in 'Uri','Method','Headers','Body','ContentType','ExpandProperty','Property','RemoveProperty','PSTypeName') {
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
        $invokeParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($invokeParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Invoke-TssRestApi
            if (-not ${script:Invoke-RestApi}.Parameters.ContainsKey($k)) {
                $invokeParams.Remove($k) # we remove it.
            }
        }
        if ($invokeParams.PersonalAccessToken) {
            $Script:CachedPersonalAccessToken = $invokeParams.PersonalAccessToken
        }
        if (-not $invokeParams.PersonalAccessToken -and $Script:CachedPersonalAccessToken) {
            $invokeParams.PersonalAccessToken = $Script:CachedPersonalAccessToken
        }
        if ($invokeParams.Credential) {
            $script:CachedCredential = $invokeParams.Credential
        }
        if (-not $invokeParams.Credential -and $script:CachedCredential) {
            $invokeParams.Credential = $script:CachedCredential
        }

        return $invokeParams
    }

}