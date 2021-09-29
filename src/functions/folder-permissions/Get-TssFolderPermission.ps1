function Get-TssFolderPermission {
    <#
    .SYNOPSIS
    Get a folder permission(s)

    .DESCRIPTION
    Get a folder permission(s)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderPermission -TssSession $session -Id 36

    Returns Folder Permission(s) for Folder ID

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Get-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Get-TssFolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.FolderPermissions.Permission')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]$TssSession,

        # Folder Permission ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderPermissionId')]
        [int[]]
        $Id,

        # Include inactive Folder Permissions in results
        [switch]
        $IncludeInactive
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folderPermission in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-permissions', $folderPermission -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting folder permission on [$folderPermission]"
                    $err = $_
                    . $ErrorHandling $err
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