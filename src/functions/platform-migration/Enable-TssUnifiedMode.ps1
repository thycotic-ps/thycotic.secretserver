function Enable-TssUnifiedMode {
    <#
    .SYNOPSIS
    Enable Platform unified mode

    .DESCRIPTION
    Enable unified mode, which makes Secret Server read identities from the Delinea Platform. Secret Server documents this endpoint as internal use only: enabling it before the Platform migration is complete can cause unwanted results.
    Follow progress with Get-TssUnifiedModeProgress. Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AllowCompleteWithErrors
    Complete even when some objects failed to migrate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssUnifiedMode -TssSession $session
    Get-TssUnifiedModeProgress -TssSession $session

    Enable unified mode and check its progress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Enable-TssUnifiedMode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Enable-TssUnifiedMode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.PlatformMigration.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $AllowCompleteWithErrors
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'enable-unified-mode' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowCompleteWithErrors' {
                    $body.data.Add('allowCompleteWithErrors', [boolean]$AllowCompleteWithErrors)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Unified mode", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Enable-TssUnifiedMode request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PlatformMigration.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
