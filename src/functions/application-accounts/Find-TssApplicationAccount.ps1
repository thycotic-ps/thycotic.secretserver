function Find-TssApplicationAccount {
    <#
    .SYNOPSIS
    Find application accounts by name

    .DESCRIPTION
    Returns the ID and name of each application account (a user flagged as an application account), filtered by search text.
    Only active application accounts are returned unless -IncludeInactive or -IncludeAll is used.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeAll
    Include all application accounts, active and inactive

    .PARAMETER IncludeInactive
    Include inactive application accounts

    .PARAMETER SearchText
    Text to match against the application account name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssApplicationAccount -TssSession $session -SearchText svc

    Returns the active application accounts whose name contains svc

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssApplicationAccount -TssSession $session -IncludeAll

    Returns every application account, active and inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/application-accounts/Find-TssApplicationAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-accounts/Find-TssApplicationAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Folders.Lookup[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeAll,

        [switch]
        $IncludeInactive,

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
            $uri = $TssSession.ApiUrl, 'application-accounts', 'lookup' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IncludeAll' {
                    $queryParams += "filter.includeAll=$([boolean]$IncludeAll)"
                }
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
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
                Write-Warning 'Issue with Find-TssApplicationAccount request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Folders.Lookup[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Folders.Lookup]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
