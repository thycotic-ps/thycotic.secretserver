function Get-TssEventSubscriptionStub {
    <#
    .SYNOPSIS
    Get the default values for a new event subscription

    .DESCRIPTION
    Get the default values Secret Server uses for a new event subscription: whether email and Slack notifications are on.
    The server marks a channel read-only when it is not configured (no SMTP host, no Slack integration).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventSubscriptionStub -TssSession $session

    Return the default SendEmail and SendSlack values for a new event subscription

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-subscriptions/Get-TssEventSubscriptionStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-subscriptions/Get-TssEventSubscriptionStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventSubscriptions.Stub')]
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
            $uri = $TssSession.ApiUrl, 'event-subscriptions', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssEventSubscriptionStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.EventSubscriptions.Stub]@{
                    SendEmail = $restResponse.sendEmail.value
                    SendSlack = $restResponse.sendSlack.value
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
