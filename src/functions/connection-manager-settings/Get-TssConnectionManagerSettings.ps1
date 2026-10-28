function Get-TssConnectionManagerSettings {
    <#
    .SYNOPSIS
    Get the Connection Manager client settings

    .DESCRIPTION
    Get the settings Secret Server hands to the Connection Manager desktop client: whether local connections and saved credentials are allowed, the license state and the client download URL.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssConnectionManagerSettings -TssSession $session

    Get the Connection Manager client settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/connection-manager-settings/Get-TssConnectionManagerSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/connection-manager-settings/Get-TssConnectionManagerSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ConnectionManager.Settings')]
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
            $uri = $TssSession.ApiUrl, 'connection-manager-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssConnectionManagerSettings request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.ConnectionManager.Settings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ConnectionManager.Settings]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
