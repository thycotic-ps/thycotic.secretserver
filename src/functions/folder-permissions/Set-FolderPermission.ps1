function Set-FolderPermission {
    <#
    .SYNOPSIS
    Set various properties for a given FolderPermission

    .DESCRIPTION
    Set various properties for a given FolderPermission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderPermission -TssSession $session -Id 34 -FolderId 5 -FolderAccessRoleName Edit -SecretAccessRoleName View

    Set Folder Permission ID 34 on Folder ID 5 to Edit folder permission and View secret permission

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssFolderPermission

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'all')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Folder Permission Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("FolderPermissionId")]
        [int[]]
        $Id,

        # Folder ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int]
        $FolderId,

        # Role to grant on the folder: View, Edit, Add Secret, Owner
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [ValidateSet('View','Edit','Add Secret', 'Owner')]
        [string]
        $FolderAccessRolename,

        # Role to grant on the secret: View, Edit, List, Owner
        [ValidateSet('View', 'Edit', 'List', 'Owner')]
        [string]
        $SecretAccessRoleName,

        # Allow updating of inherited permissions
        [switch]
        $BreakInheritance
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folderPermission in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-permissions', $folderPermission -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $setBody = @{
                    id = $Id
                    folderId = $FolderId
                    folderAccessRoleName = $FolderAccessRoleName
                }
                if ($setParams.ContainsKey('SecretAccessRoleName')) {
                    $setBody.Add('secretAccessRoleName',$SecretAccessRoleName)
                }
                if ($setParams.ContainsKey('BreakInheritance')) {
                    $setBody.Add('breakInheritance',[boolean]$BreakInheritance)
                }
                $invokeParams.Body = $setBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("FolderPermissionID: ${5}", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue setting property on  [$]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    Write-Verbose "FolderPermissionId [$FolderPermissionId] set"
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}