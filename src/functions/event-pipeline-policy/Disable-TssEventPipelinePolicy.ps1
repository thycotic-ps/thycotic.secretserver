function Disable-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Disable an Event Pipeline Policy

    .DESCRIPTION
    Disable an Event Pipeline Policy

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssEventPipelinePolicy -TssSession $session -Id 43

    Disable Event Pipeline Policy 43

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Disable-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Disable-TssEventPipelinePolicy.ps1

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
        [Alias('EventPipelinePolicyId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($policy in $Id) {
                $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $policy, 'activate' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $DisablePipelineBody = @{ Activate = $false }
                $invokeParams.Body = $DisablePipelineBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $restResponse = . $InvokeApi @invokeParams
                    } catch {
                        Write-Warning "Issue disabling Event Pipeline Policy [$policy]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if (-not $restResponse) {
                        Write-Verbose "Event Pipeline Policy [$policy] Disabled"
                    } else {
                        Write-Warning "Event Pipeline Policy [$policy] not successfully Disabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}