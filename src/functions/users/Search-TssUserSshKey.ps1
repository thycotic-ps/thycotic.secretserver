function Search-TssUserSshKey {
    <#
    .SYNOPSIS
    List user public SSH keys

    .DESCRIPTION
    Lists user public SSH keys, active and unexpired by default.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeExpired
    Include expired keys

    .PARAMETER IncludeInactive
    Include deactivated keys

    .PARAMETER SearchText
    Text to match against the key description

    .PARAMETER UserId
    Only keys of this user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserSshKey -TssSession $session

    Lists the active, unexpired public SSH keys

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssUserSshKey -TssSession $session -UserId 42 -IncludeInactive

    Lists the public SSH keys of user 42, deactivated keys included

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Search-TssUserSshKey

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Search-TssUserSshKey.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.SshKey[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeExpired,

        [switch]
        $IncludeInactive,

        [string]
        $SearchText,

        [int]
        $UserId
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
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IncludeExpired' {
                    $queryParams += "filter.includeExpired=$([boolean]$IncludeExpired)"
                }
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'UserId' {
                    $queryParams += "filter.userId=$($UserId)"
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
                Write-Warning 'Issue with Search-TssUserSshKey request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Users.SshKey[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Users.SshKey]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
