function Get-TssPlatformMigrationProgress {
    <#
    .SYNOPSIS
    Get the progress of a Delinea Platform migration run

    .DESCRIPTION
    Returns how far a Delinea Platform data migration run has got: status, processed and total item counts, and whether it is still running.
    Without -Id the server reports the current or most recent run.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Migration run ID. Omit for the current or most recent run

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformMigrationProgress -TssSession $session

    Returns the progress of the current or most recent migration run

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformMigrationProgress -TssSession $session -Id 3

    Returns the progress of migration run 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformMigrationProgress

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformMigrationProgress.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.Progress')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('MigrationId')]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($tssParams.ContainsKey('Id')) {
                $uri = $TssSession.ApiUrl, 'platform-migration', 'progress', $Id -join '/'
            } else {
                $uri = $TssSession.ApiUrl, 'platform-migration', 'progress' -join '/'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformMigrationProgress request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformMigration.Progress](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.Progress]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
