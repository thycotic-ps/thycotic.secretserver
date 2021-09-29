function Update-TssUserPassword {
    <#
    .SYNOPSIS
    Update current User's password

    .DESCRIPTION
    Update current User's password. Successful update of password will expire the current session.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssUserPassword -TssSession $session -Current $ssCred.Password -New (ConvertTo-SecureString 'P@ssword$h1p@lw@y$')

    Updates the user's password for the current session

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssUserPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssUserPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Current password
        [Parameter(Mandatory, Position = 1)]
        [securestring]
        $Current,

        [Parameter(Mandatory, Position = 2)]
        # New password to update
        [securestring]
        $New
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', 'change-password' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $changePwdBody = @{
                currentPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Current))
                newPassword     = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($New))
            }
            $invokeParams.Body = $changePwdBody | ConvertTo-Json

            if ($PSCmdlet.ShouldProcess('Updating Password', "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue updating password for current user'
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose 'Password updated successfully'
                $TssSession.SessionExpire() >$null
            } else {
                Write-Warning 'Password was not updated successfully, see previous errors'
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}