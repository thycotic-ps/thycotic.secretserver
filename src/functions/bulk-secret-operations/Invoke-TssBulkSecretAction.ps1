function Invoke-TssBulkSecretAction {
    <#
    .SYNOPSIS
    Run a bulk action on secrets

    .DESCRIPTION
    Run one bulk action on one or more secrets: activate, deactivate, turn auto change, checkout, heartbeat, hide launcher password or require view comment on or off, run heartbeat, or turn permission inheritance on.
    Each call sends one request for all the secrets passed to -Id.
    The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    IDs of the secrets to act on

    .PARAMETER Action
    Bulk action to run: Activate, Deactivate, EnableAutoChange, DisableAutoChange, EnableCheckout, DisableCheckout, EnableHeartbeat, DisableHeartbeat, RunHeartbeat, EnableHideLauncherPassword, DisableHideLauncherPassword, EnableRequireViewComment, DisableRequireViewComment, EnableInheritPermissions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssBulkSecretAction -TssSession $session -Id 42, 43 -Action Deactivate

    Deactivate secrets 42 and 43

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssBulkSecretAction -TssSession $session -Id 42, 43 -Action RunHeartbeat | Get-TssBulkOperationProgress -TssSession $session

    Run a heartbeat on secrets 42 and 43, then check the progress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-secret-operations/Invoke-TssBulkSecretAction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-secret-operations/Invoke-TssBulkSecretAction.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.BulkOperations.Response')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('Activate', 'Deactivate', 'EnableAutoChange', 'DisableAutoChange', 'EnableCheckout', 'DisableCheckout', 'EnableHeartbeat', 'DisableHeartbeat', 'RunHeartbeat', 'EnableHideLauncherPassword', 'DisableHideLauncherPassword', 'EnableRequireViewComment', 'DisableRequireViewComment', 'EnableInheritPermissions')]
        [string]
        $Action
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.2.000004' $PSCmdlet.MyInvocation
            switch ($Action) {
                'Activate' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'activate' -join '/'
                }
                'Deactivate' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'deactivate' -join '/'
                }
                'EnableAutoChange' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'enable-autochange' -join '/'
                }
                'DisableAutoChange' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'disable-autochange' -join '/'
                }
                'EnableCheckout' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'enable-checkout' -join '/'
                }
                'DisableCheckout' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'disable-checkout' -join '/'
                }
                'EnableHeartbeat' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'enable-heartbeat' -join '/'
                }
                'DisableHeartbeat' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'disable-heartbeat' -join '/'
                }
                'RunHeartbeat' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'run-heartbeat' -join '/'
                }
                'EnableHideLauncherPassword' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'enable-hide-launcher-password' -join '/'
                }
                'DisableHideLauncherPassword' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'disable-hide-launcher-password' -join '/'
                }
                'EnableRequireViewComment' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'enable-require-view-comment' -join '/'
                }
                'DisableRequireViewComment' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'disable-require-view-comment' -join '/'
                }
                'EnableInheritPermissions' {
                    $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'enable-inherit-permissions' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ secretIds = $Id } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret IDs: $($Id -join ', ')", "$Action with $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssBulkSecretAction request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.BulkOperations.Response](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.BulkOperations.Response]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
