function Update-UserPassword {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssUserPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-UserPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Current password
        [Parameter(Mandatory,Position = 1)]
        [securestring]
        $Current,

        [Parameter(Mandatory,Position = 2)]
        # New password to update
        [securestring]
        $New
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.0000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', 'change-password' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $changePwdBody = @{
                currentPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Current))
                newPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($New))
            }
            $invokeParams.Body = $changePwdBody | ConvertTo-Json

            if ($PSCmdlet.ShouldProcess("Updating Password", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue updating password for current user"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose "Password updated successfully"
                $TssSession.SessionExpire() >$null
            } else {
                Write-Warning "Password was not updated successfully, see previous errors"
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}