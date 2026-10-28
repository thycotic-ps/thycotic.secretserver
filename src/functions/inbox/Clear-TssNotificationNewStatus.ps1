function Clear-TssNotificationNewStatus {
    <#
    .SYNOPSIS
    Clear the new notification indicator for the current user

    .DESCRIPTION
    Marks the current user's inbox notifications as viewed, which clears the new notification badge, as opening the inbox does.
    Returns True on success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssNotificationNewStatus -TssSession $session

    Clear the new notification indicator

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssNotificationNewStatus -TssSession $session; (Get-TssNotificationStatus -TssSession $session).InboxNotificationTotal

    Clear the indicator and show that no new inbox notifications remain

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Clear-TssNotificationNewStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Clear-TssNotificationNewStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'notifications', 'clear-new-message-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Notification new status", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssNotificationNewStatus request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
