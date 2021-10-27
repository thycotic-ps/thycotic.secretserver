function Test-TssSecretState {
    <#
    .SYNOPSIS
    Test for a State on a Secret

    .DESCRIPTION
    Test for a State on a Secret

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Test-TssSecretState -TssSession $session -SecretId 75 -State RequiresCheckout

    Test for state RequiresCheckout on Secret ID 75, returning true if exists and false if not

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Test-TssSecretState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Test-TssSecretState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Possible Secret States:
    'None','RequiresApproval','RequiresCheckout','RequiresComment','RequiresDoubleLockPassword','CreateDoubleLockPassword','DoubleLockNoAccess','CannotView','RequiresUndelete','RequiresCheckoutPendingRPC','RequiresCheckoutAndComment'
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

        # State to test for
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.SecretStates]
        $State
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Get-TssInvocation $PSCmdlet.MyInvocation
            $SecretResult = Get-TssSecretState $TssSession $SecretId

            if (-not $SecretResult) {
                Write-Warning "No result returned for Secret [$SecretId]"
            } else {
                $SecretResult.TestState([string]$State)
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}