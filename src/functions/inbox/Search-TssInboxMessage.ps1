function Search-TssInboxMessage {
    <#
    .SYNOPSIS
    Search the inbox messages of the current user

    .DESCRIPTION
    Search the inbox messages of the current user, optionally by message type, read status and creation date.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER MessageTypeId
    Return only messages of these inbox message types (InboxMessageTypeId from Search-TssInboxMessageType)

    .PARAMETER ReadStatus
    Return only Read or Unread messages (default All)

    .PARAMETER StartDate
    Return only messages created on or after this date

    .PARAMETER EndDate
    Return only messages created on or before this date

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxMessage -TssSession $session -ReadStatus Unread

    Return the unread inbox messages of the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxMessage -TssSession $session -MessageTypeId 4 -StartDate (Get-Date).AddDays(-7)

    Return the messages of inbox message type 4 created in the last seven days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxMessage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxMessage.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.Message[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Alias('InboxMessageTypeId')]
        [int[]]
        $MessageTypeId,

        [ValidateSet('Read', 'Unread', 'All')]
        [string]
        $ReadStatus,

        [datetime]
        $StartDate,

        [datetime]
        $EndDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'inbox', 'messages' -join '/'
            $searchUris = @($uri)
            if ($tssParams.ContainsKey('MessageTypeId')) {
                $searchUris = $MessageTypeId | Select-Object -Unique | ForEach-Object { $uri, $_ -join '/' }
            }
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ReadStatus' {
                    $queryParams += "filter.readStatusFilter=$ReadStatus"
                }
                'StartDate' {
                    $queryParams += "filter.startDate=$([uri]::EscapeDataString($StartDate.ToString('o')))"
                }
                'EndDate' {
                    $queryParams += "filter.endDate=$([uri]::EscapeDataString($EndDate.ToString('o')))"
                }
            }
            $invokeParams.Method = 'GET'
            foreach ($searchUri in $searchUris) {
                $restResponse = $null
                $invokeParams.Uri = $searchUri, ($queryParams -join '&') -join '?'
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssInboxMessage request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Inbox.Message[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Inbox.Message]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
