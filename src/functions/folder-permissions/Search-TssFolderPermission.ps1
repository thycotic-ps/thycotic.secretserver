function Search-TssFolderPermission {
    <#
    .SYNOPSIS
    Search folder permissions

    .DESCRIPTION
    Search folder permissions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssFolderPermission -TssSession $session -FolderId 32

    Return Folder Permissions for Folder ID 32

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folder-permissions/Search-TssFolderPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folder-permissions/Search-TssFolderPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.FolderPermissions.Permission')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]$TssSession,

        # Folder ID
        [int]
        $FolderId,

        # Group ID
        [int]
        $GroupId,

        # User ID
        [int]
        $UserId,

        # Sort by specific property, default Folder Permission ID
        [string]
        $SortBy = 'Id'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($tssParams.ContainsKey('FolderId') -or $tssParams.ContainsKey('GroupId') -or $tssParams.ContainsKey('UserId')) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder-permissions' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

                $filters = @()
                if ($tssParams.ContainsKey('FolderId')) {
                    $filters += "filter.folderId=$FolderId"
                }
                if ($tssParams.ContainsKey('GroupId')) {
                    $filters += "filter.groupId=$GroupId"
                }
                if ($tssParams.ContainsKey('UserId')) {
                    $filters += "filter.userId=$UserId"
                }
                if ($filters) {
                    $uriFilter = $filters -join '&'
                    Write-Verbose "Filters: $uriFilter"
                    $uri = $uri, $uriFilter -join '&'
                }

                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue on search request'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                    Write-Warning 'No Folder Permissions found'
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.FolderPermissions.Permission[]]$restResponse.records
                }
            } else {
                Write-Error 'Please provide one of the following parameters: -FolderId, -GroupId or -UserId'
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}