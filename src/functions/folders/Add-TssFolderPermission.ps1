function Add-TssFolderPermission {
    <#
    .SYNOPSIS
    Add a User or Group permission to a Folder

    .DESCRIPTION
    Add a User or Group permission to a Folder. Use -Force to break inheritance.

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssFolderPermission -TssSession $session -Id 65 -Username bob -FolderRole Owner -SecretRole Edit

    Add bob to Folder 65 granting Folder role of owner and Secret role of Edit

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folders = Search-TssFolder -TssSession $session | Where-Object -not InheritPermission
    $folders | Add-TssFolderPermission -TssSession $session -Username chance.wayne -FolderRole View -SecretRole List

    Add "chance.wayne" to all Folders that do not have Inherit Permissions enabled. Granting Folder role of View and Secret Role of List

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folders = Search-TssFolder -TssSession $session -SearchText 'App'
    $folders | Add-TssFolderPermission -TssSession $session -Username chad -FolderRole Owner -SecretRole Owner -Force

    Add "chad" as owner for Folder and Secret on Folders that have "App" in their name, will also break inheritance if enabled on any of the Folders

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Add-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Add-TssFolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.FolderPermissions.Permission')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $FolderId,

        # Name of user to add
        [Parameter(Mandatory, ParameterSetName = 'user')]
        [string]
        $Username,

        # Name of group to add
        [Parameter(Mandatory, ParameterSetName = 'group')]
        [string]
        $Group,

        # Folder Access Role (View, Edit, Add Secret, Owner)
        [Parameter(Mandatory, ParameterSetName = 'user')]
        [Parameter(Mandatory, ParameterSetName = 'group')]
        [ValidateSet('View', 'Edit', 'Add Secret', 'Owner')]
        [string]
        $FolderRole,

        # Secret Access Role (View, Edit, List, Owner, None)
        [Parameter(Mandatory, ParameterSetName = 'user')]
        [Parameter(Mandatory, ParameterSetName = 'group')]
        [ValidateSet('View', 'Edit', 'List', 'Owner', 'None')]
        [string]
        $SecretRole,

        # If provided will break inheritance on the folder and add the permission
        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

            if ($tssParams.ContainsKey('Username')) {
                $users = Search-TssUser -TssSession $TssSession
                $userId = $users.Where({ $_.Username -eq $Username }).Id
            }
            if ($tssParams.ContainsKey('Group')) {
                $groups = Search-TssGroup -TssSession $TssSession
                $groupId = $groups.Where({ $_.GroupName -eq $Group }).Id
            }

            if ($userId.Count -gt 1) {
                Write-Warning "More than one matching Username was found, please provide a more unique name"
                return
            } elseif ($groupId.Count -gt 1) {
                Write-Warning "More than one matching Group Name was found, please provide a more unique name"
                return
            }

            if ($userId -or $groupId) {
                $newFolderPermParams = @{
                    TssSession           = $TssSession
                    FolderId             = $FolderId
                    FolderAccessRoleName = $FolderRole
                    SecretAccessRoleName = $SecretRole
                }
                if ($userId) {
                    $newFolderPermParams.Add('UserId',$userId)
                } elseif ($groupId) {
                    $newFolderPermParams.Add('GroupId',$groupId)
                }
                if ($tssParams.ContainsKey('Force')) {
                    $newFolderPermParams.Add('Force',$Force)
                }
                New-TssFolderPermission @newFolderPermParams
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}