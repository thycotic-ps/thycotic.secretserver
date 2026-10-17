function Get-TssUserTotpStatus {
    <#
    .SYNOPSIS
    Get the authenticator app setup of the current user

    .DESCRIPTION
    Returns the TOTP account name, secret key and otpauth URL for setting up an authenticator app for the current user.
    The output is key material: the secret key and URL generate valid one-time codes for the account.
    Fails when TOTP two-factor authentication is not enabled for the current user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserTotpStatus -TssSession $session

    Returns the authenticator app setup of the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserTotpStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserTotpStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.TotpStatus')]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'totp-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssUserTotpStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Users.TotpStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.TotpStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
