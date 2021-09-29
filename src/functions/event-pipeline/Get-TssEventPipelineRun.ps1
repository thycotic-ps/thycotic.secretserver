function Get-TssEventPipelineRun {
    <#
    .SYNOPSIS
    Get all of the runs for an Event Pipeline

    .DESCRIPTION
    Get all of the runs for an Event Pipeline

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineRun -TssSession $session -Id 42

    Outputs the Activity details for Event Pipeline 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline/Get-TssEventPipelineRun

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineRun.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.RunView')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("EventPipelineId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($pipeline in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'event-pipeline', 'runs' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=eventPipelineId&take=$($TssSession.Take)" -join '?'

                $uriFilter = "filter.eventPipelineId=$pipeline" -join '&'
                $uri = $uri, $uriFilter -join '&'

                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Activity for Event Pipeline [$pipeline]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.EventPipeline.RunView[]]$restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}