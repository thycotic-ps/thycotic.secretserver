function Get-TssSshCipherSuiteAudit {
    <#
    .SYNOPSIS
    Get the audit trail of an SSH cipher suite

    .DESCRIPTION
    Returns one entry per change made to the SSH cipher suite with the given ID: who made it, when, the action, and any notes.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH cipher suite ID (a GUID)

    .PARAMETER SearchTerm
    Return only entries that match this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCipherSuiteAudit -TssSession $session -Id '6c1e4f0a-2b7d-4c39-9a51-0d8e3f6b2a17'

    Returns the audit entries for the SSH cipher suite with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCipherSuite -TssSession $session | Get-TssSshCipherSuiteAudit -TssSession $session

    Returns the audit entries for every active SSH cipher suite

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Get-TssSshCipherSuiteAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Get-TssSshCipherSuiteAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCipherSuite.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCipherSuiteConfigurationId')]
        [string[]]
        $Id,

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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'ssh-cipher-suite', $currentId, 'audit' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'SearchTerm' {
                        $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
                    }
                }
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSshCipherSuiteAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.SshCipherSuite.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCipherSuite.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
