function Copy-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Copy an event pipeline policy

    .DESCRIPTION
    Creates a copy of an event pipeline policy, with its pipelines, and returns the new policy.
    With Id the policy is exported first (Export-TssEventPipelinePolicy) and the export is duplicated; with Data an export made earlier is duplicated.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID to copy

    .PARAMETER Data
    Event pipeline policy export (JSON text from Export-TssEventPipelinePolicy) to duplicate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Copy-TssEventPipelinePolicy -TssSession $session -Id 3

    Creates a copy of event pipeline policy 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $export = Export-TssEventPipelinePolicy -TssSession $session -Id 3
    Copy-TssEventPipelinePolicy -TssSession $session -Data $export

    Duplicates a policy from an export

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Copy-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Copy-TssEventPipelinePolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.Policy')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [Alias('EventPipelinePolicyId')]
        [int]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'data')]
        [string]
        $Data
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'duplicate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $policyExport = $Data
            $target = 'Event pipeline policy export'
            if ($PSCmdlet.ParameterSetName -eq 'id') {
                $target = "Event pipeline policy: $Id"
                $policyExport = Export-TssEventPipelinePolicy -TssSession $TssSession -Id $Id -ErrorAction Stop
                if (-not $policyExport) {
                    Write-Warning "No export returned for event pipeline policy [$Id]"
                    return
                }
            }
            $body = @{ data = $policyExport }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess($target, "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Copy-TssEventPipelinePolicy request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventPipelinePolicy.Policy](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipelinePolicy.Policy]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
