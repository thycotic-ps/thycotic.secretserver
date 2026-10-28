function New-TssEventSubscription {
    <#
    .SYNOPSIS
    Create a new event subscription

    .DESCRIPTION
    Create a new event subscription that sends an inbox notification when one of its entity actions happens.
    Each entity action pairs an entity type with one of its actions, as returned by Search-TssEventType.
    The calling user is added as a subscriber.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Name of the event subscription

    .PARAMETER EntityAction
    One or more entity actions, as hashtables or objects with these properties: EventEntityType (Entity from Search-TssEventType, for example User or Secret), EventActionId (eventActionId of one of that type's Actions), EventEntityTypeDisplayName and EventActionDisplayName (both required by the server). Optional: ItemId, ItemName, ContainerId, IncludeSubcontainers, ConditionType.

    .PARAMETER Active
    Activate the event subscription on creation

    .PARAMETER SendEmail
    Send an email when the event happens (requires an SMTP host)

    .PARAMETER SendSlack
    Send a Slack message when the event happens (requires the Slack integration)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $action = @{ EventEntityType = 'User'; EventEntityTypeDisplayName = 'User'; EventActionId = 1; EventActionDisplayName = 'Create' }
    New-TssEventSubscription -TssSession $session -Name 'User created' -EntityAction $action -Active

    Create an active event subscription that notifies the caller whenever a user is created

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/New-TssEventSubscription

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/New-TssEventSubscription.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventSubscriptions.EventSubscription')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SubscriptionName')]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [object[]]
        $EntityAction,

        [switch]
        $Active,

        [switch]
        $SendEmail,

        [switch]
        $SendSlack
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
            $uri = $TssSession.ApiUrl, 'event-subscriptions' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    subscriptionName = $Name
                    entityActions    = @($EntityAction)
                    active           = [boolean]$Active
                    sendEmail        = [boolean]$SendEmail
                    sendSlack        = [boolean]$SendSlack
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event subscription: $Name", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssEventSubscription request'
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
