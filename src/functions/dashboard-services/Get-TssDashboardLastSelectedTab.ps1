function Get-TssDashboardLastSelectedTab {
    <#
    .SYNOPSIS
    Get the dashboard tab the current user selected last

    .DESCRIPTION
    Returns the dashboard tab the current user selected last, which is the tab the dashboard opens on. When no tab was saved, or the saved tab no longer exists, the server returns the system tab.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDashboardLastSelectedTab -TssSession $session

    Get the dashboard tab the current user selected last

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDashboardLastSelectedTab -TssSession $session | Search-TssDashboardTabWidget -TssSession $session

    List the widgets on the tab the dashboard opens on

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardLastSelectedTab

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardLastSelectedTab.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardTab')]
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
            $uri = $TssSession.ApiUrl, 'dashboard-services', 'tabs', 'last-selected' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDashboardLastSelectedTab request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DashboardServices.DashboardTab](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardTab]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
