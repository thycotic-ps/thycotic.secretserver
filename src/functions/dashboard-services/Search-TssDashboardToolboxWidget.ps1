function Search-TssDashboardToolboxWidget {
    <#
    .SYNOPSIS
    List the widgets that can be added to a dashboard tab

    .DESCRIPTION
    Returns the toolbox widgets for the dashboard tab with the given id: the widget types not yet placed on the tab. Id is the widget type id; TabWidgetId is 0 because the widget is not on the tab. The list is not paged.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dashboard tab id.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardToolboxWidget -TssSession $session -Id 1

    List the widgets that can still be added to dashboard tab 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardToolboxWidget

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardToolboxWidget.ps1

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
                $uri = $TssSession.ApiUrl, 'dashboard-services', 'tabs', $currentId, 'toolbox-widgets' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssDashboardToolboxWidget request'
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
