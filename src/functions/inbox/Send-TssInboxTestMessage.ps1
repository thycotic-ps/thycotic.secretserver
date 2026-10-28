function Send-TssInboxTestMessage {
    <#
    .SYNOPSIS
    Send a test inbox message

    .DESCRIPTION
    Sends a test message through the inbox to the current user, or to the members of a group, to check inbox and email delivery.
    EmailConfigured on the result is False when email (SMTP) is not configured: the message then only reaches the inbox.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Subject
    Subject of the test message

    .PARAMETER Message
    Body of the test message

    .PARAMETER GroupId
    Send the message to the members of this group instead of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Send-TssInboxTestMessage -TssSession $session -Subject 'Inbox test' -Message 'Testing inbox delivery'

    Send a test message to the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Send-TssInboxTestMessage -TssSession $session -Subject 'Inbox test' -Message 'Testing inbox delivery' -GroupId 5

    Send a test message to the members of group 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Send-TssInboxTestMessage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Send-TssInboxTestMessage.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Inbox.TestMessageResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Subject,

        [Parameter(Mandatory)]
        [string]
        $Message,

        [int]
        $GroupId
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
            $uri = $TssSession.ApiUrl, 'inbox', 'send-test-message' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Subject' {
                    $body.data.Add('subject', $Subject)
                }
                'Message' {
                    $body.data.Add('message', $Message)
                }
                'GroupId' {
                    $body.data.Add('groupId', $GroupId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox test message", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Send-TssInboxTestMessage request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Inbox.TestMessageResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.TestMessageResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
