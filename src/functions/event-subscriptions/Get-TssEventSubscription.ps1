function Get-TssEventSubscription {
    <#
    .SYNOPSIS
    Get an event subscription

    .DESCRIPTION
    Get an event subscription by ID, including its entity actions and subscribers.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event subscription ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventSubscription -TssSession $session -Id 4

    Return event subscription 4 with its entity actions and subscribers

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventSubscription -TssSession $session | Get-TssEventSubscription -TssSession $session

    Return the full details of every active event subscription

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Get-TssEventSubscription

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Get-TssEventSubscription.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventSubscriptions.EventSubscription')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventSubscriptionId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'event-subscriptions', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssEventSubscription request'
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
