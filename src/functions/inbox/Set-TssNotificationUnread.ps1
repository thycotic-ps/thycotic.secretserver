function Set-TssNotificationUnread {
    <#
    .SYNOPSIS
    Mark system alert notifications as unread

    .DESCRIPTION
    Marks one or more system alert notifications as unread again for the current user.
    The server returns False when the user has no read record for the ID, such as an alert that was never marked read or an ID that does not exist.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER NotificationId
    Notification ID (a GUID, the NotificationId property of Search-TssNotification output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssNotificationUnread -TssSession $session -NotificationId 'a5780772-5ee3-40d9-a257-a86b8e5c7052'

    Mark one system alert as unread

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssNotification -TssSession $session | Where-Object IsRead | Set-TssNotificationUnread -TssSession $session

    Mark every read system alert as unread

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssNotificationUnread

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssNotificationUnread.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        $NotificationId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $NotificationId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'notifications', 'notification-unread' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $invokeParams.Body = @{ notificationId = $currentId } | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Notification: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue with Set-TssNotificationUnread request for notification [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [System.Convert]::ToBoolean($restResponse)
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
