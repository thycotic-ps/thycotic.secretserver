function Search-TssPlatformUser {
    <#
    .SYNOPSIS
    Search the Delinea Platform users

    .DESCRIPTION
    List the Delinea Platform users known to this Secret Server, with their directory service and membership type.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IsDomainUser
    Return domain users only

    .PARAMETER SearchText
    Start of the name. The Platform matches names that start with this text; * is not a wildcard, so 'adm' finds admin but 'adm*' does not

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformUser -TssSession $session -SearchText 'adm'

    Find Platform users whose name starts with adm

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Search-TssPlatformUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Search-TssPlatformUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers with an error.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.User[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IsDomainUser,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform', 'users' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IsDomainUser' {
                    $queryParams += "filter.isDomainUser=$([boolean]$IsDomainUser)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
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
                Write-Warning 'Issue with Search-TssPlatformUser request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Platform.User[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Platform.User]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
