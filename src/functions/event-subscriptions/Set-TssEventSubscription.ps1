function Set-TssEventSubscription {
    <#
    .SYNOPSIS
    Update an event subscription

    .DESCRIPTION
    Update an event subscription. Only the parameters provided are changed.
    EntityAction and SubscriberGroupId replace the whole list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event subscription ID

    .PARAMETER Name
    New name of the event subscription

    .PARAMETER Active
    Activate (-Active) or deactivate (-Active:$false) the event subscription

    .PARAMETER InboxExpiration
    Number of days a notification stays in the inbox

    .PARAMETER EntityAction
    Replacement list of entity actions, as hashtables or objects with these properties: EventEntityType, EventActionId, EventEntityTypeDisplayName, EventActionDisplayName, and optional ItemId, ItemName, ContainerId, IncludeSubcontainers, ConditionType (same shape as New-TssEventSubscription)

    .PARAMETER SubscriberGroupId
    Replacement list of subscriber group IDs (a user subscribes through their personal group)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssEventSubscription -TssSession $session -Id 4 -Name 'User created (audit)' -InboxExpiration 30

    Rename event subscription 4 and keep its notifications for 30 days

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssEventSubscription -TssSession $session -Id 4 -Active:$false

    Deactivate event subscription 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Set-TssEventSubscription

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Set-TssEventSubscription.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventSubscriptions.EventSubscription')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventSubscriptionId')]
        [int]
        $Id,

        [Alias('SubscriptionName')]
        [string]
        $Name,

        [switch]
        $Active,

        [int]
        $InboxExpiration,

        [object[]]
        $EntityAction,

        [int[]]
        $SubscriberGroupId
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
            $uri = $TssSession.ApiUrl, 'event-subscriptions', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('subscriptionName', @{ dirty = $true; value = $Name })
                }
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'InboxExpiration' {
                    $body.data.Add('inboxExpiration', @{ dirty = $true; value = $InboxExpiration })
                }
                'EntityAction' {
                    $body.data.Add('entityActions', @{ dirty = $true; value = @($EntityAction) })
                }
                'SubscriberGroupId' {
                    $body.data.Add('subscribers', @{ dirty = $true; value = @($SubscriberGroupId) })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event subscription: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssEventSubscription request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventSubscriptions.EventSubscription](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventSubscriptions.EventSubscription]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
