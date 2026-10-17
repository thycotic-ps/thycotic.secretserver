function Update-TssDashboardTabWidgetState {
    <#
    .SYNOPSIS
    Replace the saved state of a dashboard widget

    .DESCRIPTION
    Replaces the state string saved for a widget on a dashboard tab, the value the web UI keeps for settings such as a filter or page size. The previous state is overwritten, not merged. Read it first with Get-TssDashboardTabWidgetState to restore it later.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TabWidgetId
    Id of the widget on the tab, the TabWidgetId property of Search-TssDashboardTabWidget output. Not the widget type id.

    .PARAMETER State
    New widget state. A string is saved as is; any other object is saved as compressed JSON.

    .PARAMETER Clear
    Remove the saved state, so the widget falls back to its defaults.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3 -State @{ pageSize = 25 }

    Save the state of widget 3 as the JSON text of the hashtable

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $old = Get-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3
    if ($null -eq $old) {
        Update-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3 -Clear
    } else {
        Update-TssDashboardTabWidgetState -TssSession $session -TabWidgetId 3 -State $old
    }

    Restore a widget state read earlier, clearing it when the widget had no saved state

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Update-TssDashboardTabWidgetState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Update-TssDashboardTabWidgetState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'state')]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardWidgetStateResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $TabWidgetId,

        [Parameter(Mandatory, ParameterSetName = 'state')]
        [AllowEmptyString()]
        [object]
        $State,

        [Parameter(Mandatory, ParameterSetName = 'clear')]
        [switch]
        $Clear
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($PSCmdlet.ParameterSetName -eq 'clear' -and -not $Clear) {
            return
        }
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dashboard-services', 'tab-widgets', $TabWidgetId, 'state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $stateText = if ($Clear) {
                $null
            } elseif ($State -is [string]) {
                $State
            } else {
                $State | ConvertTo-Json -Depth 100 -Compress
            }
            $body = @{ data = @{ tabWidgetState = $stateText } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dashboard tab widget state: $TabWidgetId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDashboardTabWidgetState request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DashboardServices.DashboardWidgetStateResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardWidgetStateResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
