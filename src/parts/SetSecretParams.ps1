<#
.Synopsis
    Gets Set-TssSecret's parameters
.Description
    Gets the parameters for Set-TssSecret from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Set-TssSecret will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Set-TssSecret}) {
        # If we haven't cached a reference to Set-TssSecret,
        ${script:Set-TssSecret} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Set-TssSecret', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $setSecretParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($setSecretParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Set-TssSecret
            if (-not ${script:Set-TssSecret}.Parameters.ContainsKey($k)) {
                $setSecretParams.Remove($k) # we remove it.
            }
        }
        return $setSecretParams
    }
}