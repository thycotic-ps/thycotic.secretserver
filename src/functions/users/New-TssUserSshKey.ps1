function New-TssUserSshKey {
    <#
    .SYNOPSIS
    Create an SSH key pair for the current user

    .DESCRIPTION
    Creates an SSH key pair for the current user, stores the public key and returns the private key as text.
    The output is private key material and is returned only once: save it securely.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Algorithm
    Key algorithm: RSA, DSA, ECDSA or EdDSA

    .PARAMETER Description
    Description of the key

    .PARAMETER Format
    Private key file format: OpenSSH or PuTTY

    .PARAMETER Passphrase
    Passphrase that protects the private key

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $privateKey = New-TssUserSshKey -TssSession $session -Description deploy -Format OpenSSH -Algorithm EdDSA

    Creates an EdDSA key pair in OpenSSH format and keeps the private key in a variable

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/New-TssUserSshKey

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/New-TssUserSshKey.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('RSA', 'DSA', 'ECDSA', 'EdDSA')]
        [string]
        $Algorithm,

        [Parameter(Mandatory)]
        [string]
        $Description,

        [Parameter(Mandatory)]
        [ValidateSet('OpenSSH', 'PuTTY')]
        [string]
        $Format,

        [securestring]
        $Passphrase
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'public-ssh-keys' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Algorithm' {
                    $body.Add('algorithm', $Algorithm)
                }
                'Description' {
                    $body.Add('description', $Description)
                }
                'Format' {
                    $body.Add('format', $Format)
                }
                'Passphrase' {
                    $body.Add('passphrase', [System.Net.NetworkCredential]::new('', $Passphrase).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("SSH key", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssUserSshKey request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
