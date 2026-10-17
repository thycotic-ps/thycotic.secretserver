function Set-TssGroup {
    <#
    .SYNOPSIS
    Update a group

    .DESCRIPTION
    Changes the name, enabled state, owner groups or IP address restrictions of a group. Only the parameters you pass are sent; everything else stays as it is.
    To change members use Add-TssGroupMember, Remove-TssGroupMember or Set-TssGroupMember.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER Name
    New name for the group

    .PARAMETER Enabled
    Enable the group. Use -Enabled:$false to disable it

    .PARAMETER OwnerGroupId
    Group IDs that own the group. Replaces the current owner groups

    .PARAMETER AddOwnerGroupId
    Group IDs to add as owners. Takes precedence over OwnerGroupId

    .PARAMETER RemoveOwnerGroupId
    Group IDs to remove as owners. Takes precedence over OwnerGroupId

    .PARAMETER IpAddressRestrictionId
    IP address restriction IDs for the group. Replaces the current restrictions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssGroup -TssSession $session -Id 42 -Name 'Help Desk'

    Renames group 42 to Help Desk

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssGroup -TssSession $session -Id 42 -Enabled:$false

    Disables group 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssGroup -TssSession $session -Id 42 -AddOwnerGroupId 7

    Adds group 7 as an owner of group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Set-TssGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Set-TssGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Groups.Group')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int]
        $Id,

        [string]
        $Name,

        [switch]
        $Enabled,

        [int[]]
        $OwnerGroupId,

        [int[]]
        $AddOwnerGroupId,

        [int[]]
        $RemoveOwnerGroupId,

        [int[]]
        $IpAddressRestrictionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'groups', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'OwnerGroupId' {
                    $body.data.Add('ownerGroupIds', @{ dirty = $true; value = $OwnerGroupId })
                }
                'AddOwnerGroupId' {
                    $body.data.Add('addedOwnerGroupIds', $AddOwnerGroupId)
                }
                'RemoveOwnerGroupId' {
                    $body.data.Add('removedOwnerGroupIds', $RemoveOwnerGroupId)
                }
                'IpAddressRestrictionId' {
                    $body.data.Add('ipAddressRestrictionIds', @{ dirty = $true; value = $IpAddressRestrictionId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Group: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssGroup request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    $ownerGroups = $null
                    $ownerUsers = $null
                    if ($restResponse.hasGroupOwners) {
                        $ownerGroups = foreach ($ownerGroupId in $restResponse.ownerGroups.PSObject.Properties.Name) {
                            [pscustomobject]@{
                                GroupId   = $ownerGroupId
                                GroupName = $restResponse.ownerGroups.$ownerGroupId
                            }
                        }
                        $ownerUsers = foreach ($ownerUserId in $restResponse.ownerUsers.PSObject.Properties.Name) {
                            [pscustomobject]@{
                                UserId   = $ownerUserId
                                Username = $restResponse.ownerUsers.$ownerUserId
                            }
                        }
                    }
                    [Thycotic.PowerShell.Groups.Group]@{
                        AdGuid         = $restResponse.adGuid
                        CanEditMembers = $restResponse.canEditMembers
                        Created        = $restResponse.created
                        DomainId       = $restResponse.domainId
                        DomainName     = $restResponse.domainName
                        Enabled        = $restResponse.enabled
                        HasGroupOwners = $restResponse.hasGroupOwners
                        Id             = $restResponse.id
                        IsEditable     = $restResponse.isEditable
                        Name           = $restResponse.name
                        OwnerGroups    = $ownerGroups
                        Owners         = $restResponse.owners
                        OwnerUsers     = $ownerUsers
                        Synchronized   = $restResponse.synchronized
                        SynchronizeNow = $restResponse.synchronizeNow
                        SystemGroup    = $restResponse.systemGroup
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
