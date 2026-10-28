function Update-TssSecretSshRestrictedCommand {
    <#
    .SYNOPSIS
    Update the SSH command restrictions of a secret

    .DESCRIPTION
    Replaces the SSH command restrictions of a secret, including whether commands are restricted, the restriction type, and the menus or blocklists that apply.
    A switch left out is turned off and a CommandRestrictionType left out resets to AllowedMenu; menus and blocklists left out are kept. Returns True on success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER AutoCheckIn
    Check the secret back in after the request completes

    .PARAMETER AutoCheckout
    Check out the secret automatically when it requires checkout

    .PARAMETER AutoComment
    Comment to record with the automatic checkout, for secrets that require a comment

    .PARAMETER ForceCheckIn
    Force check in the secret if another user has it checked out

    .PARAMETER AllowOwnersUnrestrictedCommands
    Let secret owners run any command

    .PARAMETER CommandRestrictionType
    AllowedMenu limits users to command menus; BlockedList blocks the commands in blocklists

    .PARAMETER RestrictSshCommands
    Restrict the SSH commands users can run on the secret. To remove the restrictions pass -RestrictSshCommands:$false with -AllowOwnersUnrestrictedCommands; Secret Server applies the AllowedMenu rule even when restrictions are off

    .PARAMETER SshCommandBlocklist
    Blocklists per role, one hashtable each: @{ sshCommandBlocklistId = <guid>; rolePermissionId = <id> }

    .PARAMETER SshCommandMenu
    Command menus per group, one hashtable each: @{ sshCommandMenuId = <id>; groupId = <id> }

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretSshRestrictedCommand -TssSession $session -Id 42 -RestrictSshCommands -CommandRestrictionType AllowedMenu -SshCommandMenu @{ sshCommandMenuId = 3; groupId = 15 }

    Limits group 15 to command menu 3 on secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretSshRestrictedCommand -TssSession $session -Id 42 -RestrictSshCommands:$false -AllowOwnersUnrestrictedCommands

    Removes the SSH command restrictions from secret 42. Without -AllowOwnersUnrestrictedCommands or a command menu Secret Server rejects the call

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretSshRestrictedCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretSshRestrictedCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires a Secret Server license that includes SSH command restrictions.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment,

        [switch]
        $ForceCheckIn,

        [switch]
        $AllowOwnersUnrestrictedCommands,

        [ValidateSet('AllowedMenu', 'BlockedList')]
        [string]
        $CommandRestrictionType,

        [Parameter(Mandatory)]
        [switch]
        $RestrictSshCommands,

        [object[]]
        $SshCommandBlocklist,

        [object[]]
        $SshCommandMenu
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'update-ssh-restricted-commands' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'AutoCheckIn' {
                    $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                }
                'AutoCheckout' {
                    $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                }
                'AutoComment' {
                    $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                }
                'ForceCheckIn' {
                    $queryParams += "forceCheckIn=$([boolean]$ForceCheckIn)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowOwnersUnrestrictedCommands' {
                    $body.data.Add('allowOwnersUnrestrictedCommands', [boolean]$AllowOwnersUnrestrictedCommands)
                }
                'CommandRestrictionType' {
                    $body.data.Add('commandRestrictionType', $CommandRestrictionType)
                }
                'RestrictSshCommands' {
                    $body.data.Add('restrictSshCommands', [boolean]$RestrictSshCommands)
                }
                'SshCommandBlocklist' {
                    $body.data.Add('sshCommandBlocklists', $SshCommandBlocklist)
                }
                'SshCommandMenu' {
                    $body.data.Add('sshCommandMenus', $SshCommandMenu)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret ssh restricted command: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretSshRestrictedCommand request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
