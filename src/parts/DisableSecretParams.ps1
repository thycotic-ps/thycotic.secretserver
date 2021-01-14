<#
.Synopsis
    Gets Disable-TssSecret's parameters
.Description
    Gets the parameters for Disable-TssSecret from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Disable-TssSecret will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Disable-TssSecret}) {
        # If we haven't cached a reference to Disable-TssSecret,
        ${script:Disable-TssSecret} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Disable-TssSecret', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $disableSecretParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($disableSecretParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Disable-TssSecret
            if (-not ${script:Disable-TssSecret}.Parameters.ContainsKey($k)) {
                $disableSecretParams.Remove($k) # we remove it.
            }
        }
        return $disableSecretParams
    }
}