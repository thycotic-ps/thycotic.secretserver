function Set-TssNotificationRead {
    <#
    .SYNOPSIS
    Mark system alert notifications as read

    .DESCRIPTION
    Marks one or more system alert notifications as read for the current user.
    The server returns True for any ID, including one that does not exist.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER NotificationId
    Notification ID (a GUID, the NotificationId property of Search-TssNotification output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssNotificationRead -TssSession $session -NotificationId 'a5780772-5ee3-40d9-a257-a86b8e5c7052'

    Mark one system alert as read

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssNotification -TssSession $session | Set-TssNotificationRead -TssSession $session

    Mark every system alert as read

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssNotificationRead

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssNotificationRead.ps1

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
                $uri = $TssSession.ApiUrl, 'notifications', 'notification-read' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $invokeParams.Body = @{ notificationId = $currentId } | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Notification: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue with Set-TssNotificationRead request for notification [$currentId]"
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
