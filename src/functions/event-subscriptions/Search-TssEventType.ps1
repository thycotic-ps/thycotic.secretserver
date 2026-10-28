function Search-TssEventType {
    <#
    .SYNOPSIS
    Search the event types available to event subscriptions

    .DESCRIPTION
    Search the entity types an event subscription can watch, each with its actions (eventActionId) and condition types.
    Use the Entity and an action's eventActionId to build the EntityAction parameter of New-TssEventSubscription and Set-TssEventSubscription.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventType -TssSession $session | Where-Object Entity -eq 'User' | Select-Object -ExpandProperty Actions

    Return the actions an event subscription can watch on users

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Search-TssEventType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Search-TssEventType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventSubscriptions.EventType[]')]
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
            $uri = $TssSession.ApiUrl, 'event-subscriptions', 'event-types' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssEventType request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.EventSubscriptions.EventType[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventSubscriptions.EventType]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
