function Get-TssGeneralLog {
    <#
    .SYNOPSIS
    Get the general diagnostics log

    .DESCRIPTION
    Gets the general log shown under Admin, Diagnostics as one string: comma-separated sections with the server, database, distributed engine, site, license, thread, application, remote password changing and discovery settings, plus recent dependency, backup, engine and site log entries.
    Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGeneralLog -TssSession $session

    Get the general diagnostics log

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGeneralLog -TssSession $session | Set-Content C:\export\general-log.csv

    Save the general diagnostics log to a file

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssGeneralLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssGeneralLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'general-logs' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssGeneralLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                if ($restResponse.StartsWith('"')) { $restResponse | ConvertFrom-Json } else { $restResponse }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
