<#
.Synopsis
    Gets Search-TssSecret's parameters
.Description
    Gets the parameters for Search-TssSecret from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Search-TssSecret will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Search-TssSecret}) {
        # If we haven't cached a reference to Search-TssSecret,
        ${script:Search-TssSecret} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Search-TssSecret', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $findSecreteParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($findSecreteParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Search-TssSecret
            if (-not ${script:Search-TssSecret}.Parameters.ContainsKey($k)) {
                $findSecreteParams.Remove($k) # we remove it.
            }
        }
        return $findSecreteParams
    }
}