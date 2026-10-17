function Test-TssSlack {
    <#
    .SYNOPSIS
    Send a test message to Slack

    .DESCRIPTION
    Sends a test Slack message with the saved Slack configuration and returns True when Slack accepted it.
    Returns False, not an error, when Slack is not configured or rejects the message.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssSlack -TssSession $session

    Check that the saved Slack configuration can send a message

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    if (-not (Test-TssSlack -TssSession $session)) { Get-TssSlackConfiguration -TssSession $session | Select-Object AppId, SecretInteractionsEnabled, InboxNotificationsEnabled }

    Show the Slack settings when the test fails

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Test-TssSlack

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Test-TssSlack.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
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
            $restResponse = $null
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'slack-test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssSlack request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse) {
                [boolean]$restResponse.success
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
