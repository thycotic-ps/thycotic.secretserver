function Get-TssConfigurationSettingsMenu {
    <#
    .SYNOPSIS
    Get the settings menu configuration

    .DESCRIPTION
    Returns the ids of the settings menu items that are not available on this instance (Hidden), and the Privilege Manager link when Privilege Manager is installed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssConfigurationSettingsMenu -TssSession $session).Hidden

    List the settings menu items hidden on this instance

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfigurationSettingsMenu

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfigurationSettingsMenu.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SettingsMenu')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'settings-menu' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssConfigurationSettingsMenu request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.SettingsMenu](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SettingsMenu]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
