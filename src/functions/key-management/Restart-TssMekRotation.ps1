function Restart-TssMekRotation {
    <#
    .SYNOPSIS
    Retry a failed master encryption key rotation

    .DESCRIPTION
    Retries the master encryption key rotation process from its current status, after a step failed.
    The server answers even when there is nothing to retry: check CanRetryStatus, ProcessState and ErrorMessage on the output. Follow progress with Get-TssMekRotationInfo.
    This changes how Secret Server encrypts its data: a wrong or interrupted change can leave Secret Server or its secrets unreadable.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Restart-TssMekRotation -TssSession $session

    Retry the master encryption key rotation after a failure

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    if ((Get-TssMekRotationInfo -TssSession $session).CanRetryStatus) { Restart-TssMekRotation -TssSession $session -Confirm:$false }

    Retry the rotation only when the server allows a retry

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Restart-TssMekRotation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Restart-TssMekRotation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.KeyManagement.MekRotation')]
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
            Compare-TssVersion $TssSession '11.1.000006' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'key-management', 'retrymekstatus' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            if (Confirm-TssDangerousOperation $PSCmdlet EncryptionKeys "Master encryption key" "$($invokeParams.Method) $uri" -Force:$Force) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Restart-TssMekRotation request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.KeyManagement.MekRotation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.KeyManagement.MekRotation]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
