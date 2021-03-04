function Search-FolderPermission {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search_TssFolderPermission

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssFolderPermissionSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

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
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
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

                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue on search request"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                    Write-Warning "No Folder Permissions found"
                }
                if ($restResponse.records) {
                    . $TssFolderPermissionSummaryObject $restResponse.records
                }
            } else {
                Write-Error "Please provide one of the following parameters: -FolderId, -GroupId or -UserId"
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}