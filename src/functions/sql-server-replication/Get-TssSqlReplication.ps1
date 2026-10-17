function Get-TssSqlReplication {
    <#
    .SYNOPSIS
    Get the SQL Server replication configuration

    .DESCRIPTION
    Gets the SQL Server replication settings of this Secret Server: whether replication is enabled and licensed, the replicated databases, the allowed and active database counts, and the publications and articles when replication is configured.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSqlReplication -TssSession $session

    Get the SQL Server replication configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSqlReplication -TssSession $session).Publications

    List the replication publications and their last synchronization status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sql-server-replication/Get-TssSqlReplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sql-server-replication/Get-TssSqlReplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    On-premises Secret Server only. Secret Server Cloud returns an access denied error.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SqlServerReplication.SqlReplication')]
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
            $uri = $TssSession.ApiUrl, 'sql-server-replication' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSqlReplication request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SqlServerReplication.SqlReplication](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SqlServerReplication.SqlReplication]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
