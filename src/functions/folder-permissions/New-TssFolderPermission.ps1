function New-TssFolderPermission {
    <#
    .SYNOPSIS
    Create a new folder permission

    .DESCRIPTION
    Create a new folder permission, use -Force to break inheritance

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssFolderPermission -TssSession $session -FolderId 5 -UserId 21 -FolderAccessRoleName View -SecretAccessRoleName List

    Creates a folder permission on Folder ID 5 for User ID 21 granting View on the Folder-level and List on the Secrets in the folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssFolderPermission -TssSession $session -FolderId 46 -GroupId 12 -FolderAccessRoleName Owner -SecretAccessRoleName Owner -Force

    Creates a folder permission on Folder ID 46 for Group ID 21, giving Owner for Folder and Secrets, breaking InheritPermissions if enabled

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/New-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/New-TssFolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.FolderPermissions.Permission')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory, ValueFromPipeline)]
        [int[]]
        $FolderId,

        # Group Id
        [Parameter(ValueFromPipeline)]
        [int]
        $GroupId,

        # User ID
        [Parameter(ValueFromPipeline)]
        [int]
        $UserId,

        # Folder Access Role Name (View, Edit, Add Secret, Owner)
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateSet('View', 'Edit', 'Add Secret', 'Owner')]
        [string]
        $FolderAccessRoleName,

        # Secret Access Role Name (View, Edit, List, Owner, None)
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateSet('View', 'Edit', 'List', 'Owner', 'None')]
        [string]
        $SecretAccessRoleName,

        # If provided will break inheritance on the folder and add the permission
        [Parameter()]
        [switch]
        $Force
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($tssNewParams.ContainsKey('UserId') -or $tssNewParams.ContainsKey('GroupId')) {
                foreach ($folder in $FolderId) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'folder-permissions' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'

                    $newBody = [ordered]@{}
                    if ($tssNewParams.ContainsKey('Force')) {
                        $newBody.Add('breakInheritance',$true)
                    } else {
                        $newBody.Add('breakInheritance',$false)
                    }
                    switch ($tssNewParams.Keys) {
                        'FolderId' { $newBody.Add('folderId', $folder) }
                        'GroupId' { $newBody.Add('groupId', $GroupId) }
                        'FolderAccessRoleName' { $newBody.Add('folderAccessRoleName', $FolderAccessRoleName) }
                        'UserId' { $newBody.Add('userId', $UserId) }
                        'SecretAccessRoleName' { $newBody.Add('secretAccessRoleName', $SecretAccessRoleName) }
                    }

                    $invokeParams.Body = $newBody | ConvertTo-Json
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
                    if (-not $PSCmdlet.ShouldProcess("Folder ID: $folder", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue creating Folder Permission on Folder [$folder]"
                        $err = $_
                        if ($err.ErrorDetails.Message) {
                            $errorMsg = $err.ErrorDetails.Message | ConvertFrom-Json
                            if ($errorMsg.Message -eq 'API_PermissionsAreInherited') {
                                Write-Error "Folder [$folder] has InheritPermissions enabled, use -Force parameter to break inheritance"
                            }
                        } else {
                            . $ErrorHandling $err
                        }
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.FolderPermissions.Permission]$restResponse
                    }
                }
            } else {
                Write-Error 'Please provide one of the following parameters: -GroupId or -UserId'
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}