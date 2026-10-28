function Update-TssDualControl {
    <#
    .SYNOPSIS
    Update a dual control

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    The server replaces the whole dual control, so the cmdlet first reads the current dual control (Get-TssDualControl) and changes only the parameters you pass; a failed read stops the cmdlet before any change.
    -ApprovalGroupId replaces the complete list of approval groups. Activating a dual control needs at least one approval group.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dual control ID

    .PARAMETER DualControlTypeId
    New dual control type ID, from Search-TssDualControlType

    .PARAMETER ItemId
    New protected item ID (report ID or secret ID)

    .PARAMETER ApprovalGroupId
    IDs of the groups whose members can approve; replaces the current list

    .PARAMETER Active
    Activate the dual control; -Active:$false deactivates it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDualControl -TssSession $session -Id 3 -Active:$false

    Deactivate dual control 3 and keep its approval groups

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDualControl -TssSession $session -Id 3 -ApprovalGroupId 4, 9 -Active

    Make groups 4 and 9 the approvers of dual control 3 and activate it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Update-TssDualControl

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Update-TssDualControl.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DualControls.DualControl')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [int]
        $DualControlTypeId,

        [int]
        $ItemId,

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
            $current = Get-TssDualControl -TssSession $TssSession -Id $Id -ErrorAction Stop
            if (-not $current) {
                Write-Error "Dual control [$Id] could not be read; nothing was changed"
                return
            }
            $groups = if ($tssParams.ContainsKey('ApprovalGroupId')) {
                @($ApprovalGroupId | ForEach-Object { @{ dualControlId = $Id; groupId = $_ } })
            } else {
                @($current.DualControlApprovalGroups | ForEach-Object { @{ dualControlApprovalGroupId = $_.Id; dualControlId = $Id; groupId = $_.GroupId } })
            }
            $body = @{
                id                        = $Id
                dualControlTypeId         = $current.DualControlTypeId
                itemId                    = $current.ItemId
                active                    = $current.Active
                dualControlApprovalGroups = @($groups)
            }
            switch ($tssParams.Keys) {
                'DualControlTypeId' {
                    $body.dualControlTypeId = $DualControlTypeId
                }
                'ItemId' {
                    $body.itemId = $ItemId
                }
                'Active' {
                    $body.active = [boolean]$Active
                }
            }
            $uri = $TssSession.ApiUrl, 'dual-controls', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dual control: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDualControl request'
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
