function Test-TssLicenseForConnectionManager {
    <#
    .SYNOPSIS
    Test whether the Secret Server license covers Connection Manager

    .DESCRIPTION
    Checks whether the Secret Server license allows Connection Manager and returns IsLicensed, IsTrial and LicenseEndDate.
    On-premises, IsLicensed is True when a valid Connection Manager subscription or evaluation key is installed. On Secret Server Cloud it follows the tenant subscription and IsTrial is always False.
    LicenseEndDate can be empty. Any signed-in user can call it; no role permission is required.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssLicenseForConnectionManager -TssSession $session

    Returns IsLicensed, IsTrial and LicenseEndDate for Connection Manager

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    if (-not (Test-TssLicenseForConnectionManager -TssSession $session).IsLicensed) { Write-Warning 'Connection Manager is not licensed' }

    Warns when the license does not cover Connection Manager

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/license/Test-TssLicenseForConnectionManager

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/license/Test-TssLicenseForConnectionManager.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.License.ValidLicense')]
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
            $uri = $TssSession.ApiUrl, 'license', 'validforconnectionmanager' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssLicenseForConnectionManager request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.License.ValidLicense](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.License.ValidLicense]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
