function Disable-TssEventPipeline {
    <#
    .SYNOPSIS
    Disable an Event Pipeline of an Event Pipeline Policy

    .DESCRIPTION
    Disable an Event Pipeline of an Event Pipeline Policy

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssEventPipeline -TssSession $session -Id 43

    Disable Event Pipeline 43

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline/Disable-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Disable-TssEventPipeline.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline ID to Disable
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelineId')]
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
                $uri = $TssSession.ApiUrl, 'event-pipeline', $pipeline, 'activate' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $DisablePipelineBody = @{ Activate = $false }
                $invokeParams.Body = $DisablePipelineBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue disabling Event Pipeline [$pipeline]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if (-not $restResponse) {
                        Write-Verbose "Event Pipeline [$pipeline] Disabled"
                    } else {
                        Write-Warning "Event Pipeline [$pipeline] not successfully Disabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}