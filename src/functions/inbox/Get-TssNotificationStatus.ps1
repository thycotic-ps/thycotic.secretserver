function Get-TssNotificationStatus {
    <#
    .SYNOPSIS
    Get the notification counts of the current user

    .DESCRIPTION
    Gets the counts behind the notification bell for the current user: system alerts, new inbox notifications and pending secret access, secret erase and application requests, plus when the notifications were last viewed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssNotificationStatus -TssSession $session

    Get the notification counts of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssNotificationStatus -TssSession $session).SecretAccessRequestPendingTotal

    Show how many secret access requests wait for the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssNotificationStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssNotificationStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.NotificationStatus')]
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'notifications', 'status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssNotificationStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Inbox.NotificationStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.NotificationStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
