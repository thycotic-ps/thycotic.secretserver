function Search-TssDashboardTabWidget {
    <#
    .SYNOPSIS
    List the widgets on a dashboard tab

    .DESCRIPTION
    Returns the widgets placed on the dashboard tab with the given id, with their position and saved state. TabWidgetId identifies the widget on the tab and is the id the widget state cmdlets take. Id is always 0 here: the server does not return the widget type id for a placed widget; ControlName names the widget type. The list is not paged.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dashboard tab id.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardTabWidget -TssSession $session -Id 1

    List the widgets on dashboard tab 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardTab -TssSession $session | Search-TssDashboardTabWidget -TssSession $session

    List the widgets on every dashboard tab of the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardTabWidget

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardTabWidget.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardWidget[]')]
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
                $uri = $TssSession.ApiUrl, 'dashboard-services', 'tabs', $currentId, 'widgets' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssDashboardTabWidget request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DashboardServices.DashboardWidget[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardWidget]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
