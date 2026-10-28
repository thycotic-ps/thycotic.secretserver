function Approve-TssDualControl {
    <#
    .SYNOPSIS
    Authorize a dual control as an approver

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    The approver authorizes the action on the given item by entering their own credentials; the result says whether the authorization succeeded. The approver must be a member of an approval group of the dual control and another user than the one signed in to the session; otherwise the server answers API_DualControlAuthFailed.
    The request body carries the approver password and is never written to the verbose stream or the ShouldProcess message.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DualControlType
    Type of item: Report, UserAuditReport, Secret, CreateReport or AllSecretSessions

    .PARAMETER Id
    Item ID (report ID or secret ID); 0 for AllSecretSessions

    .PARAMETER Credential
    Credential of the approver (a member of one of the approval groups)

    .PARAMETER DomainId
    Domain ID of the approver, for a domain account; omit for a local account

    .PARAMETER TwoFactorToken
    Two-factor token of the approver, when the approver has two-factor authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $approver = Get-Credential
    Approve-TssDualControl -TssSession $session -DualControlType Report -Id 21 -Credential $approver

    Authorize running report 21 as the approver in $approver

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Approve-TssDualControl -TssSession $session -DualControlType AllSecretSessions -Id 0 -Credential $approver -DomainId 1 -TwoFactorToken 123456

    Authorize viewing all secret sessions as a domain approver with a two-factor token

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Approve-TssDualControl

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Approve-TssDualControl.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DualControls.AuthResult')]
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
        $Id,

        [Parameter(Mandatory)]
        [PSCredential]
        $Credential,

        [int]
        $DomainId,

        [string]
        $TwoFactorToken
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dual-controls', 'auth', $DualControlType, $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $data = @{
                username = $Credential.UserName
                password = $Credential.GetNetworkCredential().Password
            }
            if ($tssParams.ContainsKey('DomainId')) {
                $data.Add('domain', $DomainId)
            }
            if ($tssParams.ContainsKey('TwoFactorToken')) {
                $data.Add('twoFactorToken', $TwoFactorToken)
            }
            $invokeParams.Body = @{ data = $data } | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dual control: $DualControlType $Id", "$($invokeParams.Method) $uri (request body not shown: it carries the approver password)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries the approver password)"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Approve-TssDualControl request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DualControls.AuthResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DualControls.AuthResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
