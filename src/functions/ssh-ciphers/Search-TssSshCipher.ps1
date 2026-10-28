function Search-TssSshCipher {
    <#
    .SYNOPSIS
    Search the algorithms available to SSH cipher suites

    .DESCRIPTION
    Returns the SSH algorithms Secret Server offers for an SSH cipher suite, one row per algorithm, with its type and whether it is FIPS compliant.
    This is the catalog of algorithms, not the cipher suites themselves (see Search-TssSshCipherSuite).
    Without -AlgorithmType it returns all four types, one request per type.
    Requires the View SSH Cipher Suite or Administer SSH Cipher Suite role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AlgorithmType
    Algorithm types to return: EncryptionAlgorithm, KeyExchangeAlgorithm, MACAlgorithm, PublicKeyAlgorithm. Default: all four

    .PARAMETER SearchTerm
    Return only algorithms whose name matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCipher -TssSession $session

    Returns every algorithm of every type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCipher -TssSession $session -AlgorithmType KeyExchangeAlgorithm | Where-Object FipsCompliant

    Returns the FIPS compliant key exchange algorithms

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-ciphers/Search-TssSshCipher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-ciphers/Search-TssSshCipher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCiphers.SshCipher')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('EncryptionAlgorithm', 'KeyExchangeAlgorithm', 'MACAlgorithm', 'PublicKeyAlgorithm')]
        [string[]]
        $AlgorithmType = @('EncryptionAlgorithm', 'KeyExchangeAlgorithm', 'MACAlgorithm', 'PublicKeyAlgorithm'),

        [string]
        $SearchTerm
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentType in $AlgorithmType) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'ssh-ciphers', 'search' -join '/'
                $queryParams = @()
                $queryParams += "filter.algorithmType=$currentType"
                if ($tssParams.ContainsKey('SearchTerm')) {
                    $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
                }
                $uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssSshCipher request'
                    $err = $_
                    . $ErrorHandling $err
                }
                foreach ($cipher in $restResponse.ciphers) {
                    [Thycotic.PowerShell.SshCiphers.SshCipher]@{
                        AlgorithmType = $currentType
                        FipsCompliant = $cipher.fipsCompliant
                        Name          = $cipher.name
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
