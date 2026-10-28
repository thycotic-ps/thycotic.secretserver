function Update-TssSlackConfiguration {
    <#
    .SYNOPSIS
    Update the Slack integration configuration

    .DESCRIPTION
    Changes the Slack integration settings. Only the values you pass are changed.
    The signature key and bot token are taken as secure strings and are not shown in verbose or WhatIf output. The result, like Get-TssSlackConfiguration, includes them in clear text.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AppId
    Slack app ID

    .PARAMETER BotToken
    Slack bot token

    .PARAMETER InboxNotificationsEnabled
    Send inbox notifications to Slack. Pass -InboxNotificationsEnabled:$false to turn it off

    .PARAMETER SecretInteractionsEnabled
    Send secret notifications to Slack and allow secret interactions from Slack. Pass -SecretInteractionsEnabled:$false to turn it off

    .PARAMETER SignatureKey
    Slack signing secret (signature key)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSlackConfiguration -TssSession $session -SecretInteractionsEnabled -InboxNotificationsEnabled

    Turn on secret interactions and inbox notifications in Slack

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSlackConfiguration -TssSession $session -AppId A0123456789 -BotToken (Read-Host -AsSecureString) -SignatureKey (Read-Host -AsSecureString)

    Set the Slack app ID, bot token and signature key

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/slack/Update-TssSlackConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/slack/Update-TssSlackConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Slack.Configuration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $AppId,

        [securestring]
        $BotToken,

        [switch]
        $InboxNotificationsEnabled,

        [switch]
        $SecretInteractionsEnabled,

        [securestring]
        $SignatureKey
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
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AppId' {
                    $body.data.Add('appId', @{ dirty = $true; value = $AppId })
                }
                'BotToken' {
                    $body.data.Add('botToken', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $BotToken).Password })
                }
                'InboxNotificationsEnabled' {
                    $body.data.Add('inboxNotificationsEnabled', @{ dirty = $true; value = [boolean]$InboxNotificationsEnabled })
                }
                'SecretInteractionsEnabled' {
                    $body.data.Add('secretInteractionsEnabled', @{ dirty = $true; value = [boolean]$SecretInteractionsEnabled })
                }
                'SignatureKey' {
                    $body.data.Add('signatureKey', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $SignatureKey).Password })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Slack configuration", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSlackConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Slack.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Slack.Configuration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
