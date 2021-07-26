function New-Folder {
    <#
    .SYNOPSIS
    Create a new folder

    .DESCRIPTION
    Create a new folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folderStub = Get-TssFolderStub -TssSession $session
    New-TssFolder -TssSession $session -FolderStub $folderStub -FolderName 'tssNewFolder' -ParentFolderId -1

    Creates a folder named "tssNewFolder" at the root of Secret Server application

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folderStub = Get-TssFolderStub -TssSession $session
    New-TssFolder -TssSession $session -FolderStub $folderStub -FolderName 'IT Dept' -ParentFolderId 27 -InheritPermissions:$false

    Creates a folder named "IT Dept" under parent folder 27 with Inherit Permissins disabled (set to No if viewed in the UI)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderStub -TssSession $session | New-TssFolder -TssSession $session -FolderName 'Marketing Dept' -ParentFolderId 27 -InheritPermissions -InheritSecretPolicy

    Creates a folder named "Marketing Dept" under parent folder 27 with inheritance enabled for Permissions and Secret Policy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/New-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/New-Folder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Folders.Folder')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Name
        [Parameter(Mandatory)]
        [string]
        $FolderName,

        # Parent Folder ID, default to root folder (-1)
        [Alias('ParentFolder')]
        [int]
        $ParentFolderId = -1,

        # Secret Policy ID
        [Alias('SecretPolicy')]
        [int]
        $SecretPolicyId,

        # Inherit Permissions
        [switch]
        $InheritPermissions,

        # Inherit Secret Policy
        [switch]
        $InheritSecretPolicy
    )

    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'folders' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newFolderStub = @{
                folderName     = $FolderName
                parentFolderId = $ParentFolderId
                folderTypeId   = 1
            }

            if ($tssParams.ContainsKey('SecretPolicyId')) {
                $newFolderStub.SecretPolicyId = $SecretPolicyId
            }
            if ($tssParams.ContainsKey('InheritPermissions')) {
                if ($ParentFolderId -eq -1 -and $InheritPermissions -eq $true) {
                    Write-Warning 'InheritPermission cannot be used in conjunction with creating a root folder [ParentFolderId = -1], please provide another FolderId'
                    return
                } else {
                    $newFolderStub.InheritPermissions = [boolean]$InheritPermissions
                }
            } else {
                $newFolderStub.InheritPermissions = $false
            }
            if ($tssParams.ContainsKey('InheritSecretPolicy')) {
                $newFolderStub.InheritSecretPolicy = [boolean]$InheritSecretPolicy
            }

            $invokeParams.Body = ($newFolderStub | ConvertTo-Json)

            Write-Verbose "$($invokeParams.Method) $uri with:`n $FolderStub"
            if (-not $PSCmdlet.ShouldProcess($FolderStub.FolderName, "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue creating folder [$ReportName]"
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Folders.Folder]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}