function Get-TssSlackConfiguration {
    <#
    .SYNOPSIS
    Get the Slack integration configuration

    .DESCRIPTION
    Gets the Slack integration settings: the Slack app ID, whether secret interactions and inbox notifications are sent to Slack, and whether the current user has a Slack ID.
    The result includes the Slack signature key and bot token in clear text: treat the output as secret.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSlackConfiguration -TssSession $session | Select-Object AppId, SecretInteractionsEnabled, InboxNotificationsEnabled

    Show the Slack settings without the signature key and bot token

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSlackConfiguration -TssSession $session).CurrentUserHasSlackId

    Check whether the current user has a Slack ID

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Get-TssSlackConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Get-TssSlackConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Slack.Configuration')]
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
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'slack-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSlackConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Slack.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Slack.Configuration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
