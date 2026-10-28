function Get-TssInboxMessageDefinition {
    <#
    .SYNOPSIS
    Get the inbox message definitions

    .DESCRIPTION
    Get the inbox message definitions: each message name with the data property names its messages carry.
    Inbox rule conditions and templates refer to these property names.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxMessageDefinition -TssSession $session | Where-Object MessageName -like '*Checkout*'

    Return the definitions of the checkout messages and their property names

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxMessageDefinition

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxMessageDefinition.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.MessageDefinition[]')]
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
            $uri = $TssSession.ApiUrl, 'inbox', 'message-definition' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
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
                Write-Warning 'Issue with Get-TssInboxMessageDefinition request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Inbox.MessageDefinition[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Inbox.MessageDefinition]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
