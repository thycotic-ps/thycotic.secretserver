function Search-TssNotification {
    <#
    .SYNOPSIS
    Search the system alert notifications of the current user

    .DESCRIPTION
    Lists the system alerts shown to the current user in the notification bell, such as missing email configuration or an unset custom URL, with their read state.
    The list is not paged. Use -MarkAlertsAsViewed to also mark the alerts as viewed, as opening the notification panel does.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeArchived
    Include archived notifications

    .PARAMETER MarkAlertsAsViewed
    Also mark the alerts as viewed (changes the user's notification state)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssNotification -TssSession $session

    List the current system alerts

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssNotification -TssSession $session | Where-Object { -not $_.IsRead } | Set-TssNotificationRead -TssSession $session

    Mark every unread system alert as read

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssNotification

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssNotification.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.Notification')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeArchived,

        [switch]
        $MarkAlertsAsViewed
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'notifications' -join '/'
            $queryParams = @()
            $queryParams += "includeArchived=$([boolean]$IncludeArchived)"
            $queryParams += "markAlertsAsViewed=$([boolean]$MarkAlertsAsViewed)"
            $uri = $uri, ($queryParams -join '&') -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssNotification request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.systemAlerts) {
                [Thycotic.PowerShell.Inbox.Notification[]](. $FilterTssResponse $restResponse.systemAlerts ([Thycotic.PowerShell.Inbox.Notification]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
