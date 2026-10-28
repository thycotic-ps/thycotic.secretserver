function Get-TssPlatformPreCheckDomain {
    <#
    .SYNOPSIS
    Get the Delinea Platform migration pre-check of directory domains

    .DESCRIPTION
    Returns the migration pre-check summary of the Secret Server directory domains: total and valid counts and the errors that would prevent or affect their migration to the Delinea Platform.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformPreCheckDomain -TssSession $session

    Returns the domain pre-check totals and errors

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.PlatformPreCheckDomain')]
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
            $uri = $TssSession.ApiUrl, 'platform-migration', 'pre-check-domains' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformPreCheckDomain request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformMigration.PlatformPreCheckDomain](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.PlatformPreCheckDomain]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
