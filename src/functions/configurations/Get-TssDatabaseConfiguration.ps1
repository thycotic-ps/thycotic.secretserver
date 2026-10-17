function Get-TssDatabaseConfiguration {
    <#
    .SYNOPSIS
    Get the database configuration

    .DESCRIPTION
    Returns the SQL Server connection settings Secret Server uses: server, database, authentication type and login name, encryption, failover and timeout, plus the configuration file path and application pool identity. No password is returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDatabaseConfiguration -TssSession $session

    Get the database configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDatabaseConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDatabaseConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.DatabaseConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'database' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDatabaseConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.DatabaseConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.DatabaseConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
