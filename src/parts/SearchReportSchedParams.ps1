<#
.Synopsis
    Gets Search-TssReportSchedule's parameters
.Description
    Gets the parameters for Search-TssReportSchedule from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Search-TssReportSchedule will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Search-TssReportSchedule}) {
        # If we haven't cached a reference to Search-TssReportSchedule,
        ${script:Search-TssReportSchedule} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Search-TssReportSchedule', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $searchReportSched = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($searchReportSched.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Search-TssReportSchedule
            if (-not ${script:Search-TssReportSchedule}.Parameters.ContainsKey($k)) {
                $searchReportSched.Remove($k) # we remove it.
            }
        }
        return $searchReportSched
    }
}