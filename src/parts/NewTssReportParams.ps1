<#
.Synopsis
    Gets New-TssReport's parameters
.Description
    Gets the parameters for New-TssReport from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in New-TssReport will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:New-TssReport}) {
        # If we haven't cached a reference to New-TssReport,
        ${script:New-TssReport} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('New-TssReport', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $newTssReportParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($newTssReportParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in New-TssReport
            if (-not ${script:New-TssReport}.Parameters.ContainsKey($k)) {
                $newTssReportParams.Remove($k) # we remove it.
            }
        }
        return $newTssReportParams
    }
}