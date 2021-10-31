function Remove-TssEventPipeline {
    <#
    .SYNOPSIS
    Remove an Event Pipeline from a specific Event Pipeline Policy

    .DESCRIPTION
    Remove an Event Pipeline from a specific Event Pipeline Policy

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssEventPipeline -TssSession $session -PipelineId 42 -PolicyId 3

    Remove Event Pipeline 42 from the Event Pipeline Policy 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Remove-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Remove-TssEventPipeline.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline Policy ID
        [Parameter(Mandatory,ValueFromPipeline,Position = 1)]
        [Alias('EventPipelinePolicyId')]
        [int]
        $PolicyId,

        # Event Pipeline ID
        [Parameter(Mandatory,ValueFromPipeline,Position = 2)]
        [Alias("EventPipelineId")]
        [int[]]
        $PipelineId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($pipeline in $PipelineId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'event-pipeline-policy',$PolicyId, 'pipeline', $pipeline -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess($pipeline,"$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue removing Event Pipeline [$pipeline] from Event Pipeline Policy [$PolicyId]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        Write-Verbose "Event Pipeline [$pipeline] successfully removed from Event Pipeline Policy [$PolicyId]"
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}