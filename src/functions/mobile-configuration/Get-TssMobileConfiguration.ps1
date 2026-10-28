function Get-TssMobileConfiguration {
    <#
    .SYNOPSIS
    Get the mobile configuration

    .DESCRIPTION
    Get the mobile app settings: how many minutes the mobile app may work offline before it must reconnect.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMobileConfiguration -TssSession $session

    Show the mobile app offline limit

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/mobile-configuration/Get-TssMobileConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mobile-configuration/Get-TssMobileConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.MobileConfiguration.Settings')]
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
            $uri = $TssSession.ApiUrl, 'mobile-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssMobileConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.MobileConfiguration.Settings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.MobileConfiguration.Settings]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
