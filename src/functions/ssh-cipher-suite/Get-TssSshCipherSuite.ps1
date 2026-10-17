function Get-TssSshCipherSuite {
    <#
    .SYNOPSIS
    Get an SSH cipher suite

    .DESCRIPTION
    Returns the SSH cipher suite with the given ID: the encryption, key exchange, MAC and public key algorithms it allows, and which of them are FIPS compliant.
    Requires the View SSH Cipher Suite or Administer SSH Cipher Suite role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH cipher suite ID (a GUID)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCipherSuite -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17'

    Returns the SSH cipher suite with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCipherSuite -TssSession $session | Get-TssSshCipherSuite -TssSession $session | Select-Object Name, EncryptionAlgorithms

    Lists the encryption algorithms each active SSH cipher suite allows

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Get-TssSshCipherSuite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Get-TssSshCipherSuite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCipherSuite.SshCipherSuite')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCipherSuiteConfigurationId')]
        [string[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'ssh-cipher-suite', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSshCipherSuite request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SshCipherSuite.SshCipherSuite](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCipherSuite.SshCipherSuite]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
