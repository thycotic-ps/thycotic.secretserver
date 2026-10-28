function Get-TssPlatformCompatibilityLevel {
    <#
    .SYNOPSIS
    Get the Delinea Platform integration compatibility level

    .DESCRIPTION
    Returns the Delinea Platform integration compatibility level of the Secret Server instance as a version (Major, Minor, Build, Revision).
    The endpoint allows anonymous access, so it answers for every session type, including a session to an instance that is not connected to the Platform.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformCompatibilityLevel -TssSession $session

    Returns the compatibility level the Secret Server instance reports for Delinea Platform integration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -AccessToken $platformToken
    $level = Get-TssPlatformCompatibilityLevel -TssSession $session
    '{0}.{1}' -f $level.Major, $level.Minor

    Uses a Delinea Platform access token and shows the major and minor compatibility level of the vault

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformCompatibilityLevel

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformCompatibilityLevel.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.CompatibilityLevel')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'compatibility-level' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformCompatibilityLevel request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Platform.CompatibilityLevel](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.CompatibilityLevel]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
