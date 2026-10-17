function Set-TssRoleGroup {
    <#
    .SYNOPSIS
    Add or remove groups assigned to a role

    .DESCRIPTION
    Adds and removes group assignments on a role in one call.
    Groups not listed stay as they are.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Role ID

    .PARAMETER GroupIdToAdd
    IDs of groups to assign to the role

    .PARAMETER GroupIdToRemove
    IDs of groups to remove from the role

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRoleGroup -TssSession $session -Id 7 -GroupIdToAdd 12, 14 -GroupIdToRemove 9

    Assigns groups 12 and 14 to role ID 7 and removes group 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Set-TssRoleGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Set-TssRoleGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Roles.UpdateResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RoleId')]
        [int]
        $Id,

        [Alias('GroupIdsToAdd')]
        [int[]]
        $GroupIdToAdd,

        [Alias('GroupIdsToRemove')]
        [int[]]
        $GroupIdToRemove
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'roles', $Id, 'groups' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'GroupIdToAdd' {
                    $body.data.Add('groupIdsToAdd', @{ dirty = $true; value = $GroupIdToAdd })
                }
                'GroupIdToRemove' {
                    $body.data.Add('groupIdsToRemove', @{ dirty = $true; value = $GroupIdToRemove })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Role: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssRoleGroup request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Roles.UpdateResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Roles.UpdateResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
