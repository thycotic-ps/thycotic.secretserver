function New-FolderPermission {
    <#
    .SYNOPSIS
    Create a new folder permission

    .DESCRIPTION
    Create a new folder permission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssFolderPermission -TssSession $session -FolderId 5 -UserId 21 -FolderAccessRoleName View -SecretAccessRoleName List

    Creates a folder permission on Folder ID 5 for User ID 21 granting View on the Folder-level and List on the Secrets in the folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolderPermission

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssFolderPermission')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory,ValueFromPipeline)]
        [int]
        $FolderId,

        # Group Id
        [Parameter(ValueFromPipeline)]
        [int]
        $GroupId,

        # User ID
        [Parameter(ValueFromPipeline)]
        [int]
        $UserId,

        # Folder Access Role Name
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateSet('View','Edit','Add Secret','Owner')]
        [string]
        $FolderAccessRoleName,

        # Secret Access Role Name
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateSet('View','Edit','List','Owner','None')]
        [string]
        $SecretAccessRoleName
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            if ($tssNewParams.ContainsKey('UserId') -or $tssNewParams.ContainsKey('GroupId')) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-permissions' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $newBody = [ordered]@{}
                switch ($tssNewParams.Keys) {
                    'FolderId' { $newBody.Add('folderId',$FolderId) }
                    'GroupId' { $newBody.Add('groupId',$GroupId) }
                    'FolderAccessRoleName' { $newBody.Add('folderAccessRoleName',$FolderAccessRoleName) }
                    'UserId' { $newBody.Add('userId',$UserId) }
                    'SecretAccessRoleName' { $newBody.Add('secretAccessRoleName',$SecretAccessRoleName) }
                }

                $invokeParams.Body = $newBody | ConvertTo-Json

                Write-Verbose "$($invokeParams.Method) $uri with:`n $newBody"
                if (-not $PSCmdlet.ShouldProcess("FolderID: $FolderId", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue creating Folder Permission on Folder [$FolderId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    . $TssFolderPermissionObject $restResponse
                }
            } else {
                Write-Error "Please provide one of the following parameters: -GroupId or -UserId"
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}