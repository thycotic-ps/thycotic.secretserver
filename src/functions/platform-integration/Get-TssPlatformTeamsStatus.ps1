function Get-TssPlatformTeamsStatus {
    <#
    .SYNOPSIS
    Get the Teams status for Platform data integration

    .DESCRIPTION
    Get whether Teams are enabled on this Secret Server, as Platform data integration reports it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformTeamsStatus -TssSession $session

    Show whether Teams are enabled

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformTeamsStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformTeamsStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformIntegration.TeamsStatus')]
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
            $uri = $TssSession.ApiUrl, 'platform-integration', 'teams-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformTeamsStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformIntegration.TeamsStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformIntegration.TeamsStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
