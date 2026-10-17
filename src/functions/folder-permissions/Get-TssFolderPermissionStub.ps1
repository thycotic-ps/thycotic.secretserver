function Get-TssFolderPermissionStub {
    <#
    .SYNOPSIS
    Get the default values for a new folder permission

    .DESCRIPTION
    Get the default values for a new folder permission on a folder (permission ID 0, no user or group, default folder and secret roles).
    Nothing is saved; use New-TssFolderPermission to add the permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FolderId
    Folder ID the new permission is for

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderPermissionStub -TssSession $session -FolderId 27

    Returns the default folder permission values for folder 27

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssFolderPermissionStub -TssSession $session -FolderId 27).FolderAccessRoleName

    Returns the folder role a new permission on folder 27 gets by default

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Get-TssFolderPermissionStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Get-TssFolderPermissionStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.FolderPermissions.Permission')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $FolderId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'folder-permissions', 'stub' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'FolderId' {
                    $queryParams += "folderId=$($FolderId)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssFolderPermissionStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.FolderPermissions.Permission](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.FolderPermissions.Permission]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
