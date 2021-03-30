function New-Folder {
    <#
    .SYNOPSIS
    Create a new folder

    .DESCRIPTION
    Create a new folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folderStub = Get-TssFolderStub -TssSession $session
    $folderStub.FolderName = 'tssNewFolder'
    $folderStub.ParentFolderId = -1
    New-TssFolder -TssSession $session -FolderStub $folderStub

    Creates a new root folder, named "tssNewFolder"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folderStub = Get-TssFolderStub -TssSession $session
    $folderStub.FolderName 'IT Dept'
    $folderStub.ParentFolderId = 27
    $folderStub.InheritPermissions = $false
    New-TssFolder -TssSession $session -FolderStub $folderStub

    Creates a folder named "IT Dept" under parent folder 27 with Inherit Permissins disabled

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $folderStub.FolderName 'Marketing Dept'
    $folderStub.ParentFolderId = 27
    $folderStub.InheritPermissions = $true
    $folderStub.InheritSecretPolicy = $true
    New-TssFolder -TssSession $session -FolderStub $folderStub

    Creates a folder named "Marketing Dept" under parent folder 27 with Inheritance enabled for Permissions and Secret Policy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/New-Folder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssFolder')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Input object obtained via Get-TssFolderStub
        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [TssFolder]
        $FolderStub
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

            $invokeParams.Body = ($FolderStub | ConvertTo-Json)

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
                [TssFolder]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}