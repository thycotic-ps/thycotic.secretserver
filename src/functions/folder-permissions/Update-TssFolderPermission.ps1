function Update-TssFolderPermission {
    <#
    .SYNOPSIS
    Update properties for a given FolderPermission

    .DESCRIPTION
    Update properties for a given FolderPermission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssFolderPermission -TssSession $session -Id 34 -FolderId 5 -FolderAccessRoleName Edit -SecretAccessRoleName View

    Update Folder Permission ID 34 on Folder ID 5 to Edit folder permission and View secret permission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssFolderPermission -TssSession $session -Id 45 -FolderId 72 -FolderAccessRoleName Owner

    Update Folder Permission ID 45 on Folder ID 72 to Owner folder permission

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Update-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Update-TssFolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.FolderPermissions.Permission')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]$TssSession,

        # Folder Permission Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderPermissionId')]
        [int[]]
        $Id,

        # Folder ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $FolderId,

        # Role to grant on the folder: View, Edit, Add Secret, Owner
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateSet('View', 'Edit', 'Add Secret', 'Owner')]
        [string]
        $FolderAccessRolename,

        # Role to grant on the secret: View, Edit, List, Owner
        [ValidateSet('View', 'Edit', 'List', 'Owner','None')]
        [string]
        $SecretAccessRoleName,

        # Allow updating of inherited permissions
        [switch]
        $BreakInheritance
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folderPermission in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-permissions', $folderPermission -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $setBody = @{
                    id                   = $folderPermission
                    folderId             = $FolderId
                    folderAccessRoleName = $FolderAccessRoleName
                }
                if ($setParams.ContainsKey('SecretAccessRoleName')) {
                    $setBody.Add('secretAccessRoleName', $SecretAccessRoleName)
                }
                if ($setParams.ContainsKey('BreakInheritance')) {
                    $setBody.Add('breakInheritance', [boolean]$BreakInheritance)
                }
                $invokeParams.Body = $setBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("FolderPermissionID: $folderPermission", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting property on folder permission [$folderPermission]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.FolderPermissions.Permission]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}