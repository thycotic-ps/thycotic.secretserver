function New-TssDualControl {
    <#
    .SYNOPSIS
    Create a dual control

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    Creates a dual control of the given type with the groups whose members can approve. Types that protect one item (a report or a secret) need -ItemId; All Secrets Session Access protects all items and takes no -ItemId.
    Get the type IDs from Search-TssDualControlType. The dual control is created inactive unless -Active is passed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DualControlTypeId
    Dual control type ID, from Search-TssDualControlType

    .PARAMETER ItemId
    ID of the protected item (report ID or secret ID); omit for All Secrets Session Access

    .PARAMETER ApprovalGroupId
    IDs of the groups whose members can approve

    .PARAMETER Active
    Create the dual control active

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDualControl -TssSession $session -DualControlTypeId 1 -ItemId 21 -ApprovalGroupId 4 -Active

    Require a member of group 4 to approve each run of report 21

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $type = Search-TssDualControlType -TssSession $session | Where-Object Name -eq 'All Secrets Session Access'
    New-TssDualControl -TssSession $session -DualControlTypeId $type.Id -ApprovalGroupId 4, 7 -Active

    Require a member of group 4 or 7 to approve viewing all secret sessions

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/New-TssDualControl

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/New-TssDualControl.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DualControls.DualControl')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $DualControlTypeId,

        [int]
        $ItemId,

        [Parameter(Mandatory)]
        [int[]]
        $ApprovalGroupId,

        [switch]
        $Active
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'dual-controls' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                dualControlTypeId         = $DualControlTypeId
                active                    = [boolean]$Active
                dualControlApprovalGroups = @($ApprovalGroupId | ForEach-Object { @{ groupId = $_ } })
            }
            if ($tssParams.ContainsKey('ItemId')) {
                $body.Add('itemId', $ItemId)
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dual control type: $DualControlTypeId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDualControl request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DualControls.DualControl](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DualControls.DualControl]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
