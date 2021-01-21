<#
.Synopsis
    Gets Search-TssUserGroup's parameters
.Description
    Gets the parameters for Search-TssUserGroup from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Search-TssUserGroup will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Search-TssUserGroup}) {
        # If we haven't cached a reference to Search-TssUserGroup,
        ${script:Search-TssUserGroup} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Search-TssUserGroup', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $searchReportSched = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($searchReportSched.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Search-TssUserGroup
            if (-not ${script:Search-TssUserGroup}.Parameters.ContainsKey($k)) {
                $searchReportSched.Remove($k) # we remove it.
            }
        }
        return $searchReportSched
    }
}