function Get-TssDiagnosticConnectivityReport {
    <#
    .SYNOPSIS
    Get Connectivity Report

    .DESCRIPTION
    Get Connectivity Report, built-in test to check for Internet connectivity (google.com, yahoo.com and updates.thycotic.net)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiagnosticConnectivityReport -TssSession $session

    Return test results for Internet connection from Secret Server web node

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticConnectivityReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticConnectivityReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.ConnectivityReport')]
    param (
        # TssSession object created by New-TssSession for authentication
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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'diagnostics', 'connectivity-report' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                $results = $restResponse.Trim('"').Split('  ')
                foreach ($r in $results) {
                    if ($r) {
                        switch ($r) {
                            { $_ -match 'yahoo.com' } { $address = 'www.yahoo.com' }
                            { $_ -match 'google.com' } { $address = 'www.google.com' }
                            { $_ -match 'updates.thycotic.net' } { $address = 'updates.thycotic.net' }
                        }
                        [boolean]$successful = if ($results[1].split(']')[1].Trim() -match 'FAILED') { $false } else { $true }
                        [Thycotic.PowerShell.Diagnostics.ConnectivityReport]@{
                            Address   = $address
                            IsSuccess = $successful
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}