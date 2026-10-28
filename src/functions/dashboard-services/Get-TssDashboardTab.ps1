function Get-TssDashboardTab {
    <#
    .SYNOPSIS
    Get a dashboard tab and its widgets

    .DESCRIPTION
    Returns the dashboard tab with the given id and the widgets placed on it. The tab must belong to the current user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dashboard tab id.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDashboardTab -TssSession $session -Id 1

    Get dashboard tab 1 and its widgets

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardTab -TssSession $session | Get-TssDashboardTab -TssSession $session

    Get every dashboard tab of the current user with its widgets

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardTab

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardTab.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardTabInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TabId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'dashboard-services', 'tabs', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDashboardTab request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DashboardServices.DashboardTabInfo](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardTabInfo]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
