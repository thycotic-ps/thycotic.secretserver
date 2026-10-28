function Search-TssPlatformMigrationLog {
    <#
    .SYNOPSIS
    Search the Delinea Platform migration log

    .DESCRIPTION
    Returns the log entries written by Delinea Platform data migration runs, optionally filtered by text, level, object type and date.
    Reads the migration log stored in Secret Server, so it also works on an instance without Delinea Platform integration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EndDate
    Return entries written up to this date. Can be used without -StartDate

    .PARAMETER LogLevel
    Return entries of this level

    .PARAMETER ObjectType
    Return entries about this object type

    .PARAMETER SearchTerm
    Return entries containing this text

    .PARAMETER StartDate
    Return entries written from this date. Can be used without -EndDate

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationLog -TssSession $session -LogLevel Error

    Returns the error entries of every migration run

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssPlatformMigrationLog -TssSession $session -ObjectType User -SearchTerm 'jsmith'

    Returns the user entries that mention jsmith

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Search-TssPlatformMigrationLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Search-TssPlatformMigrationLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.Log[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $EndDate,

        [ValidateSet('Debug', 'Information', 'Notice', 'Warning', 'Error', 'Critical', 'Alert', 'Emergency')]
        [string]
        $LogLevel,

        [ValidateSet('User', 'Group', 'Role', 'UnifiedMode')]
        [string]
        $ObjectType,

        [string]
        $SearchTerm,

        [datetime]
        $StartDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'logs' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'LogLevel' {
                    $queryParams += "filter.logLevel=$([uri]::EscapeDataString($LogLevel))"
                }
                'ObjectType' {
                    $queryParams += "filter.objectType=$([uri]::EscapeDataString($ObjectType))"
                }
                'SearchTerm' {
                    $queryParams += "filter.searchTerm=$([uri]::EscapeDataString($SearchTerm))"
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
                Write-Warning 'Issue with Search-TssPlatformMigrationLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.PlatformMigration.Log[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.PlatformMigration.Log]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
