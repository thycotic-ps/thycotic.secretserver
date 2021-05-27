class TssGroup {
    [string]
    $AdGuid

    [boolean]
    $CanEditMembers

    [datetime]
    $Created = [datetime]::MinValue

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