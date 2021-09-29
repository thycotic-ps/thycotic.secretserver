function Search-TssFolder {
    <#
    .SYNOPSIS
    Search secret folders

    .DESCRIPTION
    Search secret folders

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssFolder -TssSession $session -ParentFolderId 54

    Return all child folders found under root folder 54

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Search-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Search-TssFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Folders.Summary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Parent Folder Id
        [Alias('FolderId')]
        [int]
        $ParentFolderId,

        # Search by text value
        [string]
        $SearchText,

        # Filter based on folder permission (Owner, Edit, AddSecret, View). Default: View
        [ValidateSet('Owner', 'Edit', 'AddSecret', 'View')]
        [string[]]
        $PermissionRequired,

        # Sort by specific property, default FolderPath
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'folders' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)&filter.folderTypeId=1" -join '?'

            $filters = @()
            if ($tssParams.ContainsKey('ParentFolderId')) {
                $filters += "filter.parentFolderId=$ParentFolderId"
            }
            if ($tssParams.ContainsKey('SearchText')) {
                $filters += "filter.searchText=$SearchText"
            }
            if ($tssParams.ContainsKey('PermissionRequired')) {
                foreach ($perm in $PermissionRequired) {
                    $filters += "filter.permissionRequired=$perm"
                }
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
                Write-Warning 'No Folder found'
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Folders.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}