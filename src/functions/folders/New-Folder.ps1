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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolder

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssFolder')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Input object obtained via Get-TssFolderStub
        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [TssFolder]
        $FolderStub,

        # Folder Name
        [Parameter(Mandatory)]
        [string]
        $FolderName,

        # Parent Folder ID, use -1 to create root folder
        [Parameter(Mandatory)]
        [Alias('ParentFolder')]
        [int]
        $ParentFolderId,

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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'folders' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $FolderStub.FolderName = $FolderName
            $FolderStub.ParentFolderId = $ParentFolderId

            if ($tssParams.ContainsKey('SecretPolicyId')) {
                $FolderStub.SecretPolicyId = $SecretPolicyId
            }
            if ($tssParams.ContainsKey('InheritPermissions')) {
                $FolderStub.InheritPermissions = $InheritPermissions
            }
            if ($tssParams.ContainsKey('InheritSecretPolicy')) {
                $FolderStub.InheritSecretPolicy = $InheritSecretPolicy
            }

            $invokeParams.Body = ($FolderStub | ConvertTo-Json)

            Write-Verbose "$($invokeParams.Method) $uri with:`n $FolderStub"
            if (-not $PSCmdlet.ShouldProcess($FolderStub.FolderName, "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue creating folder [$ReportName]"
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                . $TssFolderObject $restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}