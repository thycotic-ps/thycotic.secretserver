function Enable-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Enable an Event Pipeline Policy

    .DESCRIPTION
    Enable an Event Pipeline Policy

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssEventPipelinePolicy -TssSession $session -Id 43

    Enable Event Pipeline Policy 43

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Enable-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Enable-TssEventPipelinePolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline ID to Enable
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyId')]
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
            foreach ($policy in $Id) {
                $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $policy, 'activate' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $EnablePipelineBody = @{ Activate = $true }
                $invokeParams.Body = $EnablePipelineBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue disabling Event Pipeline Policy [$policy]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if (-not $restResponse) {
                        Write-Verbose "Event Pipeline Policy [$policy] Enabled"
                    } else {
                        Write-Warning "Event Pipeline Policy [$policy] not successfully Enabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}