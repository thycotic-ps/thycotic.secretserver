function Get-TssPlatformMigrationDataSummary {
    <#
    .SYNOPSIS
    Get the Delinea Platform migration totals

    .DESCRIPTION
    Returns the totals of users, groups and roles: in Secret Server, migrated to the Delinea Platform and excluded, plus the counts of the last migration run.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformMigrationDataSummary -TssSession $session

    Returns the migration totals

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $summary = Get-TssPlatformMigrationDataSummary -TssSession $session
    $summary.TotalUsers - $summary.MigratedUsers - $summary.ExcludedUserCount

    Returns the number of users still to migrate

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigrationDataSummary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigrationDataSummary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.DataSummary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'data-summary' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformMigrationDataSummary request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformMigration.DataSummary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.DataSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
