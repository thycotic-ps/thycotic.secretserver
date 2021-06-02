class TssGroup {
    [string]
    $AdGuid

    [boolean]
    $CanEditMembers

    [Nullable[datetime]]
    $Created

    [int]
    $DomainId

    [string]
    $DomainName

    [boolean]
    $Enabled

    [boolean]
    $HasGroupOwners

    [int]
    $Id

    [boolean]
    $IsEditable

    [string]
    $Name

    [object[]]
    $OwnerGroups

    [TssGroupOwner[]]
    $Owners

    [object[]]
    $OwnerUsers

    [boolean]
    $Synchronized

    [boolean]
    $SynchronizeNow

    [boolean]
    $SystemGroup
}