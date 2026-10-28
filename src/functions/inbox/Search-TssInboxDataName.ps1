function Search-TssInboxDataName {
    <#
    .SYNOPSIS
    Search the inbox data names

    .DESCRIPTION
    Search the inbox data names (InboxDataId and InboxDataName) used by messages already sent.
    Use an InboxDataId as the InboxDataId of New-TssInboxRuleCondition.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER MessageTypeId
    Return only the data names used by these inbox message types (InboxMessageTypeId from Search-TssInboxMessageType)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxDataName -TssSession $session

    Return every inbox data name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxDataName -TssSession $session -MessageTypeId 4

    Return the data names used by inbox message type 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxDataName

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxDataName.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.DataName[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Alias('InboxMessageTypeId')]
        [int[]]
        $MessageTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'inbox', 'data-names' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'MessageTypeId' {
                    foreach ($queryValue in $MessageTypeId) {
                        $queryParams += "messageTypeIds=$($queryValue)"
                    }
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
                Write-Warning 'Issue with Search-TssInboxDataName request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Inbox.DataName[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.DataName]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
