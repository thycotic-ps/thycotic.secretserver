function Search-TssConfigurationBackupLog {
    <#
    .SYNOPSIS
    Search logs for the Database Backup runs

    .DESCRIPTION
    Search logs for the Database Backup runs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssConfigurationBackupLog -TssSession $session

    Returns the logs for the Database Backup processing

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssConfigurationBackupLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssConfigurationBackupLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.DbBackupLog')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Sort by specific property, default BackupTime
        [string]
        $SortBy = 'BackupTime'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'configuration', 'backup-logs' -join '/'
            $uri = $uri, "sortBy[0].direction=desc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records) {
                [Thycotic.PowerShell.Configuration.DbBackupLog[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}