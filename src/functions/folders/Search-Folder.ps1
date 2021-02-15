function Search-Folder {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssFolder

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssFolderSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Parent Folder Id
        [Alias("FolderId")]
        [int]
        $ParentFolderId,

        # Search by text value
        [string]
        $SearchText,

        # Filter based on folder permission (Owner, Edit, AddSecret, View). Default: View
        [ValidateSet('Owner','Edit','AddSecret','View')]
        [string]
        $PermissionRequired,

        # Sort by specific property, default FolderPath
        [string]
        $SortBy = 'FolderPath'
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
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)&filter.folderTypeId=1" -join '?'

            $filters = @()
            if ($tssParams.ContainsKey('ParentFolderId')) {
                $filters += "filter.parentFolderId=$ParentFolderId"
            }
            if ($tssParams.ContainsKey('SearchText')) {
                $filters += "filter.searchText=$SearchText"
            }
            if ($tssParams.ContainsKey('Permission')) {
                $filters += "filter.permissionRequired=$PermissionRequired"
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'


            Write-Verbose "$($invokeParams.Method) $uri with $body"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No Folder found"
            }
            if ($restResponse.records) {
                . $TssFolderSummaryObject $restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}