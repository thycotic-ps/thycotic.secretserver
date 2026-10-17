function Invoke-TssForgotPassword {
    <#
    .SYNOPSIS
    Send a password reset email to a user

    .DESCRIPTION
    Requests a password reset for the user with this email address.
    Secret Server emails a reset link when an enabled user matches the address and SMTP is configured.
    Fails with access denied unless password reset by email is allowed in the Secret Server configuration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EmailAddress
    Email address of the user who gets the reset link

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssForgotPassword -TssSession $session -EmailAddress user@example.com

    Sends a password reset link to the user with the email address user@example.com

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Invoke-TssForgotPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Invoke-TssForgotPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $EmailAddress
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'forgot-password' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EmailAddress' {
                    $body.data.Add('emailAddress', $EmailAddress)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Forgot password", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssForgotPassword request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Users.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
