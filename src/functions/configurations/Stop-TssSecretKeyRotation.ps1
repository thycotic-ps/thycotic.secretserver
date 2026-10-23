function Stop-TssSecretKeyRotation {
    <#
    .SYNOPSIS
    Cancel a running secret key rotation

    .DESCRIPTION
    Requests cancellation of the Rotate Secret Keys run in progress and returns the rotation status.
    Nothing changes when no rotation is running.
    This changes how Secret Server encrypts its data: a wrong or interrupted change can leave Secret Server or its secrets unreadable.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssSecretKeyRotation -TssSession $session

    Cancels the secret key rotation in progress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Stop-TssSecretKeyRotation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Stop-TssSecretKeyRotation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Configuration.SecretKeyRotationStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'security', 'cancel-rotate-secret-keys' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if (Confirm-TssDangerousOperation $PSCmdlet EncryptionKeys "Secret key rotation" "$($invokeParams.Method) $uri" -Force:$Force) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Stop-TssSecretKeyRotation request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SecretKeyRotationStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SecretKeyRotationStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
