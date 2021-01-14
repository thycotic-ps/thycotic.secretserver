<#
.Synopsis
    Gets Get-TssReportCategory's parameters
.Description
    Gets the parameters for Get-TssReportCategory from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in Get-TssReportCategory will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:Get-TssReportCategory}) {
        # If we haven't cached a reference to Get-TssReportCategory,
        ${script:Get-TssReportCategory} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('Get-TssReportCategory', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $getReportCategoryParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($getReportCategoryParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in Get-TssReportCategory
            if (-not ${script:Get-TssReportCategory}.Parameters.ContainsKey($k)) {
                $getReportCategoryParams.Remove($k) # we remove it.
            }
        }
        return $getReportCategoryParams
    }
}