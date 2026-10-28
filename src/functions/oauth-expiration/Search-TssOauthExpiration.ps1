function Search-TssOauthExpiration {
    <#
    .SYNOPSIS
    Search OAuth token expiration records

    .DESCRIPTION
    Search the OAuth token expiration records, one per issued API token that has not expired.
    Pipe the output to Invoke-TssOauthExpireBulk to expire those tokens.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER UserName
    Filter by user name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssOauthExpiration -TssSession $session -UserName 'svc-backup'

    Returns the token expiration records for user svc-backup

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/oauth-expiration/Search-TssOauthExpiration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/oauth-expiration/Search-TssOauthExpiration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.OauthExpiration.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $UserName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'oauth-expiration' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'UserName' {
                    $queryParams += "filter.userName=$([uri]::EscapeDataString($UserName))"
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
                Write-Warning 'Issue with Search-TssOauthExpiration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.OauthExpiration.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.OauthExpiration.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
