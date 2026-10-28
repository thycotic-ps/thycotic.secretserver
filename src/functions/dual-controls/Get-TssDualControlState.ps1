function Get-TssDualControlState {
    <#
    .SYNOPSIS
    Get the dual control state of an item for the current user

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    Returns ApprovalRequired when the current user needs an approver to authorize the action on the item, or AccessAllowed when no authorization is needed.
    For AllSecretSessions the item ID is not used; pass 0.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DualControlType
    Type of item: Report, UserAuditReport, Secret, CreateReport or AllSecretSessions

    .PARAMETER Id
    Item ID (report ID or secret ID); 0 for AllSecretSessions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDualControlState -TssSession $session -DualControlType Report -Id 21

    Check whether running report 21 needs a dual control approval

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDualControlState -TssSession $session -DualControlType AllSecretSessions -Id 0

    Check whether viewing all secret sessions needs a dual control approval

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControlState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControlState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DualControls.State')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateSet('Report', 'UserAuditReport', 'Secret', 'CreateReport', 'AllSecretSessions')]
        [string]
        $DualControlType,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
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
            $uri = $TssSession.ApiUrl, 'dual-controls', 'state', $DualControlType, $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDualControlState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DualControls.State](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DualControls.State]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
