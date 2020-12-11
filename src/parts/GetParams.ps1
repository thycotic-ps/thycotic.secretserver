<#
.Synopsis
    Gets $CommandName's parameters
.Description
    Gets the parameters for $CommandName from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in $CommandName will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter,

    [Parameter(ValueFromPipeline,Position = 1,Mandatory,ParameterSetName = 'GetParameterValues')]
    $CommandName
)

begin {
    if (-not ${script:"$CommandName"}) {
        # If we haven't cached a reference to $CommandName,
        ${script:"$CommandName"} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand($CommandName, 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $newParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($newParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in $CommandName
            if (-not ${script:"$CommandName"}.Parameters.ContainsKey($k)) {
                $newParams.Remove($k) # we remove it.
            }
        }
        return $newParams
    }

}