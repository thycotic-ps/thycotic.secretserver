class TssGroupAssignedRole {
    [int]
    $GroupId

    [string]
    $GroupName

}
class TssUserRoleSummary {
    [TssGroupAssignedRole[]]
    $Groups

    [boolean]
    $IsDirectAssignment

    [int]
    $RoleId

    [string]
    $RoleName
}