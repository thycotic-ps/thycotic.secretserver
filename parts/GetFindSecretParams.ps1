<#
.Synopsis
    Gets Find-TssSecret's parameters
.Description
    Gets the parameters for Find-TssSecret from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Find-TssSecret will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Find-TssSecret}) {
        # If we haven't cached a reference to Find-TssSecret,
        ${script:Find-TssSecret} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Find-TssSecret', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $findSecretParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($findSecretParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Find-TssSecret
            if (-not ${script:Find-TssSecret}.Parameters.ContainsKey($k)) {
                $findSecretParams.Remove($k) # we remove it.
            }
        }
        return $findSecretParams
    }
}