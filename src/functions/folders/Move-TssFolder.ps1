function Move-TssFolder {
    <#
    .SYNOPSIS
    Move a folder in Secret Server

    .DESCRIPTION
    Move a folder in Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssFolder -TssSession $session -Id 45 -ParentFolderId 98

    Moves folder 45 to parent folder 98, defaulting permissions and Secret Policy to inheritting from Folder 98

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssFolder -TssSession $session -Id 1092 -ParentFolderId 5409 -DisableInheritPermission

    Moves folder 1092 to parent folder 5409, disabling inherit permissions and enabling inherit Secret Policy from folder 5409

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Move-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Move-TssFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "Update-TssFolder call requires the attribute", Scope="Function", Target="*")]
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Folders.Folder')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder ID that will be moved
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Alias('FolderId')]
        [int[]]
        $Id,

        # Parent Folder ID to move the folder to
        [Parameter(Mandatory, Position = 2)]
        [int]
        $ParentFolderId,

        # Do not inherit permissions from parent folder
        [switch]
        $DisableInheritPermissions,

        # Do not inherit Secret Policy from parent folder
        [switch]
        $DisableInheritSecretPolicy
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        foreach ($folder in $Id) {
            $getFolderParams = @{
                TssSession = $TssSession
                Id         = $folder
            }
            $cFolder = Get-TssFolder @getFolderParams -ErrorAction Stop
            if ($cFolder) {
                $parentFolderParams = @{
                    TssSession = $TssSession
                    Id         = $ParentFolderId
                }
                $parentFolderState = Get-TssFolder @parentFolderParams -ErrorAction Stop

                if ($parentFolderState) {
                    $cFolder.ParentFolderId = $ParentFolderId
                    if ($tssParams.ContainsKey('DisableInheritPermission')) {
                        $cFolder.InheritPermissions = $false
                    }
                    if ($tssParams.ContainsKey('DisableInheritSecretPolicy')) {
                        $cFolder.InheritSecretPolicy = $false
                    }
                    $updateFolderParams = @{
                        TssSession = $TssSession
                        Folder     = $cFolder
                    }
                    try {
                        Update-TssFolder @updateFolderParams -ErrorAction Stop
                    } catch {
                        Write-Warning "Issue updating folder [$folder]"
                        Write-Error $_
                    }
                } else {
                    Write-Warning "Parent folder [$ParentFolderId] could not be found"
                }
            }
        }
    }
}