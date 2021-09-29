function Add-TssEventPipeline {
    <#
    .SYNOPSIS
    Add an Event Pipeline from a specific Event Pipeline Policy

    .DESCRIPTION
    Add an Event Pipeline from a specific Event Pipeline Policy

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssEventPipeline -TssSession $session -PipelineId 42 -PolicyId 3

    Add Event Pipeline 42 to the Event Pipeline Policy 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Add-TssEventPipeline

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Add-TssEventPipeline.ps1

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
                $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $PolicyId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $policyBody = @{
                    data = @{
                        eventPipelineId = @{
                            dirty = $true
                            value = $pipeline
                        }
                    }
                }
                $invokeParams.Body = $policyBody | ConvertTo-Json

                if (-not $PSCmdlet.ShouldProcess($pipeline,"$($invokeParams.Method) $uri with body:`n$($invokeParams.Body)`n")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with body:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue adding Event Pipeline [$pipeline] to Event Pipeline Policy [$PolicyId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.eventPipelineId -eq $pipeline) {
                    Write-Verbose "Event Pipeline [$pipeline] successfully added to Event Pipeline Policy [$PolicyId]"
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}