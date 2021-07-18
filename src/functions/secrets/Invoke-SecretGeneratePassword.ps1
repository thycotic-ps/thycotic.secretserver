function Invoke-SecretGeneratePassword {
    <#
    .SYNOPSIS
    Create a new Secret password

    .DESCRIPTION
    Create a new Secret password, based on password rules of the field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha/SecretServer -Credential $ssCred
    $newPassword = Invoke-TssSecretGeneratePassword -TssSession $session -Id 25 -Slug 'private-key-passphrase'
    Set-TssSecretField -TssSession $session -Id 25 -Slug 'private-key-passphrase' -Value $newPassword

    Generating password for Secret ID 25 based on password rules configured for the template, updating password field

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretGeneratePassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-SecretGeneratePassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory)]
        [Alias('SecretId')]
        [int]
        $Id,

        # Field slug name
        [Parameter(Mandatory)]
        [Alias('FieldSlug')]
        [string]
        $Slug
    )
    begin {
        $invokeGenerateParams = . $GetInvokeTssParams $TssSession

        $invokeValidateParams = . $GetInvokeTssParams $TssSession
    }
    process {
        . $InternalEndpointUsed $PSCmdlet.MyInvocation
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($PSBoundParameters.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $Id, 'generate-password', $Slug -join '/'
            $invokeGenerateParams.Uri = $uri
            $invokeGenerateParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeGenerateParams.Method) $uri"
            try {
                $restGeneratedPassword = . $InvokeApi @invokeGenerateParams
            } catch {
                Write-Warning "Issue getting generated password for Secret [$Id] and Field Slug [$Slug]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restGeneratedPassword) {
                $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $Id, 'validate-password', $Slug -join '/'
                $invokeValidateParams.Uri = $uri
                $invokeValidateParams.Method = 'POST'

                $validateBody = @{ Password = $restGeneratedPassword } | ConvertTo-Json
                $invokeValidateParams.Body = $validateBody

                Write-Verbose "Performing the operation $($invokeValidateParams.Method) $uri"
                try {
                    $restValidateResponse = . $InvokeApi @invokeValidateParams
                } catch {
                    Write-Warning "Issue validating generated password for Secret [$Id] and Field Slug [$Slug]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restValidateResponse.isValid) {
                    $restGeneratedPassword
                } else {
                    Write-Warning "Unable to validate generated password for Secret [$Id] and Field Slug [$Slug]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}