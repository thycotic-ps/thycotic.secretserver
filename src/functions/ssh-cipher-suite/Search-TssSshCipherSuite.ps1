function Search-TssSshCipherSuite {
    <#
    .SYNOPSIS
    Search SSH cipher suites

    .DESCRIPTION
    Returns the SSH cipher suites that match the filters.
    Only active cipher suites are returned unless you pass -IncludeInactive.
    Requires the View SSH Cipher Suite or Administer SSH Cipher Suite role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeActive
    Include active cipher suites. Active suites are included by default; use -IncludeActive:$false to leave them out

    .PARAMETER IncludeInactive
    Include inactive cipher suites. Defaults to on when you pass -IncludeActive:$false, off otherwise

    .PARAMETER SearchTerm
    Return only cipher suites whose name matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCipherSuite -TssSession $session -IncludeInactive

    Returns every SSH cipher suite, active or not

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCipherSuite -TssSession $session -SearchTerm 'FIPS'

    Returns the active cipher suites with "FIPS" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-cipher-suite/Search-TssSshCipherSuite

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-cipher-suite/Search-TssSshCipherSuite.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeActive,

        [switch]
        $IncludeInactive,

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
            $uri = $TssSession.ApiUrl, 'ssh-cipher-suite', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $includeActive = -not $tssParams.ContainsKey('IncludeActive') -or $IncludeActive.IsPresent
            $includeInactive = if ($tssParams.ContainsKey('IncludeInactive')) { $IncludeInactive.IsPresent } else { -not $includeActive }
            $queryParams += "filter.includeActive=$includeActive"
            $queryParams += "filter.includeInactive=$includeInactive"
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
                Write-Warning 'Issue with Search-TssSshCipherSuite request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCipherSuite.SshCipherSuiteItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
