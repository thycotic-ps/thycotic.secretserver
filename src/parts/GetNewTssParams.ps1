<#
.Synopsis
    Gets New-TssSession's parameters
.Description
    Gets the parameters for New-TssSession from a collection of parameters
#>
param(
    # A collection of parameters.  Parameters not used in New-TssSession will be removed
    [Parameter(ValueFromPipeline,Position = 0,Mandatory,ParameterSetName = 'GetParameterValues')]
    [Alias('Parameters')]
    [Collections.IDictionary]
    $Parameter
)

begin {
    if (-not ${script:New-TssSession}) {
        # If we haven't cached a reference to New-TssSession,
        ${script:New-TssSession} = # make it so.
        [Management.Automation.CommandMetaData]$ExecutionContext.SessionState.InvokeCommand.GetCommand('New-TssSession', 'Function')
    }
}

process {
    if ($PSCmdlet.ParameterSetName -eq 'GetParameterValues') {
        $newTssSessionParams = [Ordered]@{ } + $Parameter # Then we copy our parameters
        foreach ($k in @($newTssSessionParams.Keys)) {
            # and walk thru each parameter name.
            # If a parameter isn't found in New-TssSession
            if (-not ${script:New-TssSession}.Parameters.ContainsKey($k)) {
                $newTssSessionParams.Remove($k) # we remove it.
            }
        }
        return $newTssSessionParams
    }
}