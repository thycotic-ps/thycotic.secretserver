function Update-TssGroup {
    <#
    .SYNOPSIS
    Update a group with the full group model

    .DESCRIPTION
    Updates a group with the PUT endpoint. Name is required by the API; the other parameters are sent only when you pass them, and omitted settings keep their current values.
    Use this cmdlet for directory, Platform and owner settings. Set-TssGroup changes name, enabled state, owner groups and IP address restrictions with PATCH.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER Name
    Group name. Required by the API; pass the current name to keep it

    .PARAMETER Enabled
    Enable the group. Use -Enabled:$false to disable it

    .PARAMETER DomainId
    Directory domain ID. A value above 0 makes this a directory group and also applies Synchronized, SynchronizeNow and AdGuid

    .PARAMETER Synchronized
    Synchronize the group with its directory domain. Applied only with DomainId

    .PARAMETER SynchronizeNow
    Synchronize the group members on save. Applied only with DomainId

    .PARAMETER AdGuid
    Directory object GUID, or the Platform group ID with IsPlatform. Applied only with DomainId or IsPlatform

    .PARAMETER IsPlatform
    Mark the group as a Delinea Platform group. Needs AdGuid

    .PARAMETER HasGroupOwners
    Use specific owners for the group. With the owner parameters it replaces the current owners; -HasGroupOwners:$false clears them. Local groups only

    .PARAMETER OwnerUserId
    User IDs to make owners. Used with HasGroupOwners

    .PARAMETER OwnerUserName
    User names to make owners. Used with HasGroupOwners

    .PARAMETER OwnerGroupId
    Group IDs to make owners. Used with HasGroupOwners

    .PARAMETER OwnerGroupName
    Group names to make owners. Used with HasGroupOwners

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroup -TssSession $session -Id 42 | Update-TssGroup -TssSession $session -Enabled

    Enables group 42, keeping its current name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssGroup -TssSession $session -Id 42 -Name 'Help Desk' -HasGroupOwners -OwnerGroupId 7, 9

    Renames group 42 and makes groups 7 and 9 its only owners

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Update-TssGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-TssGroup.ps1

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

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $Name,

        [switch]
        $Enabled,

        [int]
        $DomainId,

        [switch]
        $Synchronized,

        [switch]
        $SynchronizeNow,

        [string]
        $AdGuid,

        [switch]
        $IsPlatform,

        [switch]
        $HasGroupOwners,

        [int[]]
        $OwnerUserId,

        [string[]]
        $OwnerUserName,

        [int[]]
        $OwnerGroupId,

        [string[]]
        $OwnerGroupName
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
            $invokeParams.Method = 'PUT'
            $body = @{ }
            $body.Add('id', $Id)
            switch ($tssParams.Keys) {
                'Name' {
                    $body.Add('name', $Name)
                }
                'Enabled' {
                    $body.Add('enabled', [boolean]$Enabled)
                }
                'DomainId' {
                    $body.Add('domainId', $DomainId)
                }
                'Synchronized' {
                    $body.Add('synchronized', [boolean]$Synchronized)
                }
                'SynchronizeNow' {
                    $body.Add('synchronizeNow', [boolean]$SynchronizeNow)
                }
                'AdGuid' {
                    $body.Add('adGuid', $AdGuid)
                }
                'IsPlatform' {
                    $body.Add('isPlatform', [boolean]$IsPlatform)
                }
                'HasGroupOwners' {
                    $body.Add('hasGroupOwners', [boolean]$HasGroupOwners)
                }
                'OwnerUserId' {
                    $body.Add('ownerUserIds', $OwnerUserId)
                }
                'OwnerUserName' {
                    $body.Add('ownerUserNames', $OwnerUserName)
                }
                'OwnerGroupId' {
                    $body.Add('ownerGroupIds', $OwnerGroupId)
                }
                'OwnerGroupName' {
                    $body.Add('ownerGroupNames', $OwnerGroupName)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Group: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssGroup request'
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
