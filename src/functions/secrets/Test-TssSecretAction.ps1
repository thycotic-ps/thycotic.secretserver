function Test-TssSecretAction {
    <#
    .SYNOPSIS
    Test for an allowed action on a Secret

    .DESCRIPTION
    Test for an allowed action on a Secret

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Test-TssSecretAction -TssSession $session -SecretId 75 -Action Edit

    Test for action Edit on Secret ID 75, returning true if exists and false if not

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Test-TssSecretAction

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Test-TssSecretAction.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Possible Secret Actions:
    'ChangePasswordNow','ConvertTemplate','Copy','Delete','Edit','EditExpiration','EditRpc','EditSecurity','Expire','Heartbeat','EditShare','ShowSshProxyCredentials','StopChangePasswordNow','ViewAudit','ViewDependencies','ViewLaunchers','ViewExpiration','ViewHooks','ViewRpc','ViewSecurity','ViewSettings','Undelete','ForceCheckIn','ViewShare','EditHooks','EditDependencies','ViewGeneralDetails','ViewHeartbeatStatus','CheckIn','Checkout','GenerateOneTimePassword','ShowSshTerminalDetails','ShowRdpProxyCredentials','ViewMetadata'
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int]
        $SecretId,

        # Action to test for
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.SecretActions]
        $Action
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Get-TssInvocation $PSCmdlet.MyInvocation
            $secretResult = Get-TssSecretState $TssSession $SecretId

            if (-not $secretResult) {
                Write-Warning "No result returned for Secret [$SecretId]"
            } else {
                $secretResult.TestAction([string]$Action)
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}