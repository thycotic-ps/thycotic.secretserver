function Start-TssMekRotation {
    <#
    .SYNOPSIS
    Start a master encryption key rotation

    .DESCRIPTION
    Rotates the Secret Server master encryption key and marks the encrypted data, recorded sessions included, for re-encryption with the new key. Data is re-encrypted in the background.
    This changes how every Secret Server node reads encrypted data. Take a database and encryption key backup first. An IIS restart on every node is needed after the key rotation completes.
    Check CanRequestRotation, ProcessState and ErrorMessage on the output. Follow progress with Get-TssMekRotationInfo.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssMekRotation -TssSession $session

    Start a master encryption key rotation, after confirming the prompt

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssMekRotation -TssSession $session -WhatIf

    Show the request that would start the rotation, without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Start-TssMekRotation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Start-TssMekRotation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.KeyManagement.MekRotation')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.1.000006' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'key-management', 'startmekrotation' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            if ($PSCmdlet.ShouldProcess("Master encryption key", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssMekRotation request'
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
