function Search-TssPlatformMigration {
    <#
    .SYNOPSIS
    Search the Delinea Platform migration runs

    .DESCRIPTION
    Returns the Delinea Platform data migration runs, optionally filtered by the user who started them and by date.
    Reads the migration history stored in Secret Server, so it also works on an instance without Delinea Platform integration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EndDate
    Return runs started up to this date. Can be used without -StartDate

    .PARAMETER StartDate
    Return runs started from this date. Can be used without -EndDate

    .PARAMETER Username
    Return runs started by users whose display name contains this text. The server matches the display name, not the login name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigration -TssSession $session

    Returns every migration run

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigration -TssSession $session -StartDate (Get-Date).AddDays(-7)

    Returns the migration runs of the last seven days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.MigrationSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $EndDate,

        [datetime]
        $StartDate,

        [string]
        $Username
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'migrations' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Username' {
                    $queryParams += "filter.username=$([uri]::EscapeDataString($Username))"
                }
            }
            if ($tssParams.ContainsKey('StartDate') -or $tssParams.ContainsKey('EndDate')) {
                $rangeStart = if ($tssParams.ContainsKey('StartDate')) { $StartDate } else { [datetime]::new(1900, 1, 1, 0, 0, 0, [System.DateTimeKind]::Utc) }
                $rangeEnd = if ($tssParams.ContainsKey('EndDate')) { $EndDate } else { [datetime]::new(9999, 1, 1, 0, 0, 0, [System.DateTimeKind]::Utc) }
                $queryParams += "filter.startDate=$([uri]::EscapeDataString($rangeStart.ToString('o')))"
                $queryParams += "filter.endDate=$([uri]::EscapeDataString($rangeEnd.ToString('o')))"
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
                Write-Warning 'Issue with Search-TssPlatformMigration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PlatformMigration.MigrationSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PlatformMigration.MigrationSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
