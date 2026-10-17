function Set-TssEmailConfiguration {
    <#
    .SYNOPSIS
    Set the outgoing email configuration

    .DESCRIPTION
    Set how Secret Server sends email: SMTP server, port, SSL mode and credentials, or an Office 365 app registration.
    Only the parameters you pass are sent; everything else keeps its current value.
    Returns the full email configuration after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FromEmailAddress
    Address every outgoing email is sent from

    .PARAMETER FromEmailName
    Display name on outgoing email

    .PARAMETER SendEmailAppRegistrationSecretId
    Id of the secret holding the Azure app registration used when SendEmailMethod is O365

    .PARAMETER SendEmailMethod
    How email is sent: Smtp or O365

    .PARAMETER SmtpCheckCertificateRevocation
    Check certificate revocation when using implicit SSL

    .PARAMETER SmtpDomain
    Domain of the SMTP account

    .PARAMETER SmtpPassword
    Password of the SMTP account

    .PARAMETER SmtpPort
    SMTP port, 25 by default

    .PARAMETER SmtpServer
    Host name of the outgoing SMTP server

    .PARAMETER SmtpUseCredentials
    Authenticate to the SMTP server; pass -SmtpUseCredentials:$false for anonymous SMTP

    .PARAMETER SmtpUseImplicitSSL
    Use implicit SSL (SMTPS) instead of STARTTLS

    .PARAMETER SmtpUserName
    User name of the SMTP account

    .PARAMETER SmtpUseSSL
    Connect to the SMTP server over SSL

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssEmailConfiguration -TssSession $session -SmtpServer smtp.example.com -SmtpPort 587 -SmtpUseSSL -FromEmailAddress secretserver@example.com

    Send email through smtp.example.com on port 587 over SSL

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $smtpCred = Get-Credential
    Set-TssEmailConfiguration -TssSession $session -SmtpUseCredentials -SmtpUserName $smtpCred.UserName -SmtpPassword $smtpCred.Password

    Authenticate to the SMTP server with the supplied account

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssEmailConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssEmailConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.EmailConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $FromEmailAddress,

        [string]
        $FromEmailName,

        [int]
        $SendEmailAppRegistrationSecretId,

        [ValidateSet('Smtp', 'O365')]
        [string]
        $SendEmailMethod,

        [switch]
        $SmtpCheckCertificateRevocation,

        [string]
        $SmtpDomain,

        [securestring]
        $SmtpPassword,

        [int]
        $SmtpPort,

        [string]
        $SmtpServer,

        [switch]
        $SmtpUseCredentials,

        [switch]
        $SmtpUseImplicitSSL,

        [string]
        $SmtpUserName,

        [switch]
        $SmtpUseSSL
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'email' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'FromEmailAddress' {
                    $body.data.Add('fromEmailAddress', @{ dirty = $true; value = $FromEmailAddress })
                }
                'FromEmailName' {
                    $body.data.Add('fromEmailName', @{ dirty = $true; value = $FromEmailName })
                }
                'SendEmailAppRegistrationSecretId' {
                    $body.data.Add('sendEmailAppRegistrationSecretId', @{ dirty = $true; value = $SendEmailAppRegistrationSecretId })
                }
                'SendEmailMethod' {
                    $body.data.Add('sendEmailMethod', @{ dirty = $true; value = $SendEmailMethod })
                }
                'SmtpCheckCertificateRevocation' {
                    $body.data.Add('smtpCheckCertificateRevocation', @{ dirty = $true; value = [boolean]$SmtpCheckCertificateRevocation })
                }
                'SmtpDomain' {
                    $body.data.Add('smtpDomain', @{ dirty = $true; value = $SmtpDomain })
                }
                'SmtpPassword' {
                    $body.data.Add('smtpPassword', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $SmtpPassword).Password })
                }
                'SmtpPort' {
                    $body.data.Add('smtpPort', @{ dirty = $true; value = $SmtpPort })
                }
                'SmtpServer' {
                    $body.data.Add('smtpServer', @{ dirty = $true; value = $SmtpServer })
                }
                'SmtpUseCredentials' {
                    $body.data.Add('smtpUseCredentials', @{ dirty = $true; value = [boolean]$SmtpUseCredentials })
                }
                'SmtpUseImplicitSSL' {
                    $body.data.Add('smtpUseImplicitSSL', @{ dirty = $true; value = [boolean]$SmtpUseImplicitSSL })
                }
                'SmtpUserName' {
                    $body.data.Add('smtpUserName', @{ dirty = $true; value = $SmtpUserName })
                }
                'SmtpUseSSL' {
                    $body.data.Add('smtpUseSSL', @{ dirty = $true; value = [boolean]$SmtpUseSSL })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Email configuration", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssEmailConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.EmailConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.EmailConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
