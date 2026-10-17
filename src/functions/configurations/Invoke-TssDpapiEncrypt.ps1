function Invoke-TssDpapiEncrypt {
    <#
    .SYNOPSIS
    Encrypt the Secret Server encryption key file with DPAPI

    .DESCRIPTION
    Protect the Secret Server encryption key file (encryption.config) with the Windows Data Protection API, the Encrypt action on the DPAPI section of the Security configuration page.
    The server re-validates your own password before it changes anything and refuses when the key is protected by an HSM.
    DPAPI binds the file to the machine key of the web server: decrypt it before you move the file to another server.
    Returns the DPAPI state after the change.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Password
    Your own Secret Server password; the server checks it before it encrypts the file

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssDpapiEncrypt -TssSession $session -Password (Read-Host -AsSecureString -Prompt 'Your password')

    Encrypt the encryption key file with DPAPI after prompting for your password

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Invoke-TssDpapiEncrypt

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Invoke-TssDpapiEncrypt.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Configuration.DpapiState')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [securestring]
        $Password
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'dpapi', 'encrypt' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Password' {
                    $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Encryption key file", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssDpapiEncrypt request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.DpapiState](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.DpapiState]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
