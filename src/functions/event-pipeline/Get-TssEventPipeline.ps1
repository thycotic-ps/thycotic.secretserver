function Get-TssEventPipeline {
    <#
    .SYNOPSIS
    Get an Event Pipeline by ID

    .DESCRIPTION
    Get an Event Pipeline by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipeline -TssSession $session -Id 43

    Output details on Event Pipeline 43

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline/Get-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipeline.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.List')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline Policy ID
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
                $uri = $TssSession.ApiUrl, 'event-pipeline', $pipeline -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Event Pipeline [$pipeline]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $GetEventPipelineList $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}