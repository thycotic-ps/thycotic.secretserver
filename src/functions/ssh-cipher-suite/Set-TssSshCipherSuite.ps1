function Set-TssSshCipherSuite {
    <#
    .SYNOPSIS
    Change an SSH cipher suite

    .DESCRIPTION
    Changes the SSH cipher suite with the given ID.
    Only the parameters you pass are changed.
    Algorithm lists are comma-separated algorithm names, as Search-TssSshCipher returns them.
    Requires the Administer SSH Cipher Suite role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH cipher suite ID (a GUID)

    .PARAMETER Active
    Use -Active to activate the cipher suite or -Active:$false to deactivate it

    .PARAMETER Description
    New description

    .PARAMETER EncryptionAlgorithms
    Comma-separated encryption algorithms the suite allows

    .PARAMETER KeyExchangeAlgorithms
    Comma-separated key exchange algorithms the suite allows

    .PARAMETER MacAlgorithms
    Comma-separated MAC algorithms the suite allows

    .PARAMETER Name
    New name

    .PARAMETER PkAlgorithms
    Comma-separated public key algorithms the suite allows

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSshCipherSuite -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17' -MacAlgorithms 'hmac-sha2-256,hmac-sha2-512'

    Limits the suite to two MAC algorithms

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSshCipherSuite -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17' -Active:$false

    Deactivates the suite

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Set-TssSshCipherSuite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Set-TssSshCipherSuite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCipherSuiteConfigurationId')]
        [string]
        $Id,

        [switch]
        $Active,

        [string]
        $Description,

        [string]
        $EncryptionAlgorithms,

        [string]
        $KeyExchangeAlgorithms,

        [string]
        $MacAlgorithms,

        [string]
        $Name,

        [string]
        $PkAlgorithms
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-cipher-suite', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('sshCipherSuiteConfigurationId', $Id)
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'EncryptionAlgorithms' {
                    $body.data.Add('encryptionAlgorithms', @{ dirty = $true; value = $EncryptionAlgorithms })
                }
                'KeyExchangeAlgorithms' {
                    $body.data.Add('keyExchangeAlgorithms', @{ dirty = $true; value = $KeyExchangeAlgorithms })
                }
                'MacAlgorithms' {
                    $body.data.Add('macAlgorithms', @{ dirty = $true; value = $MacAlgorithms })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'PkAlgorithms' {
                    $body.data.Add('pkAlgorithms', @{ dirty = $true; value = $PkAlgorithms })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh cipher suite: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSshCipherSuite request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
