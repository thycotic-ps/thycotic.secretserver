function Get-TssDashboardTabWidgetState {
    <#
    .SYNOPSIS
    Get the saved state of a dashboard widget

    .DESCRIPTION
    Returns the state string the web UI saved for a widget on a dashboard tab, usually serialized JSON such as a filter or page size. Returns nothing when no state was saved.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TabWidgetId
    Id of the widget on the tab, the TabWidgetId property of Search-TssDashboardTabWidget output. Not the widget type id.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3

    Get the saved state of the widget with tab widget id 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardTabWidget -TssSession $session -Id 1 | Get-TssDashboardTabWidgetState -TssSession $session

    Get the saved state of every widget on dashboard tab 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Get-TssDashboardTabWidgetState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Get-TssDashboardTabWidgetState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $TabWidgetId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentTabWidgetId in $TabWidgetId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'dashboard-services', 'tab-widgets', $currentTabWidgetId, 'state' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDashboardTabWidgetState request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    $state = $restResponse | ConvertFrom-Json
                    if ($null -ne $state) {
                        [string]$state
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
