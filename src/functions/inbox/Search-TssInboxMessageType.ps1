function Search-TssInboxMessageType {
    <#
    .SYNOPSIS
    Search the inbox message types

    .DESCRIPTION
    Search the inbox message types (for example Password Reset, Event Subscription).
    With IncludeCurrentUserMessageCounts the server returns only the types the current user has notifications for, with NotificationCount set.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeCurrentUserMessageCounts
    Return only the types the current user has notifications for, with their count

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxMessageType -TssSession $session

    Return every inbox message type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxMessageType -TssSession $session -IncludeCurrentUserMessageCounts

    Return the inbox message types the current user has notifications for, with the count of each

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxMessageType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxMessageType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.MessageType[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeCurrentUserMessageCounts
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'inbox', 'message-types' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'IncludeCurrentUserMessageCounts' {
                    $queryParams += "includeCurrentUserMessageCounts=$([boolean]$IncludeCurrentUserMessageCounts)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssInboxMessageType request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Inbox.MessageType[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.MessageType]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
