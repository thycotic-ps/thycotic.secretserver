function Get-TssPlatformConfiguration {
    <#
    .SYNOPSIS
    Get the Delinea Platform configuration

    .DESCRIPTION
    Get the Delinea Platform integration settings: OpenID Connect client and URLs, Platform tenant and vault Ids, synchronization intervals, audit and inventory forwarding and the login page options. The server masks the client secret.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformConfiguration -TssSession $session

    Show the Delinea Platform integration settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssPlatformConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssPlatformConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.PlatformConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'platform' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.PlatformConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.PlatformConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
