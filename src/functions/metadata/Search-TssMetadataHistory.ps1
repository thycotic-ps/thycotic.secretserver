function Search-TssMetadataHistory {
    <#
    .SYNOPSIS
    Search metadata history

    .DESCRIPTION
    Search metadata history

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Search-TssMetadataHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadataHistory.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadataHistory -TssSession $session -ItemId 5 -ItemType User

    Returns history of all metadata fields for User ID5

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Metadata.History')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Item ID to return metadata
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [int]
        $ItemId,

        # Item Type (Secret, User, Folder, Group)
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [Alias('MetadataType')]
        [Thycotic.PowerShell.Enums.MetadataType]
        $ItemType,

        # Metadata Field ID
        [Parameter(ParameterSetName = 'field')]
        [int]
        $FieldId,

        # Return history only entered before this time
        [string]
        $EndDate,

        # Return history only entered after this time
        [string]
        $StartDate,

        # Sort by specific property, default ItemId
        [string]
        $SortBy = 'ItemId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'metadata', 'history' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'ItemId' { $filters += "filter.itemId=$ItemId" }
                'FieldId' { $filters += "filter.metaDataFieldId=$FieldId" }
                'ItemType' { $filters += "filter.metadataType=$ItemType" }
                'EndDate' { $filters += "filter.endDate=$([datetime]$EndDate)" }
                'StartDate' { $filters += "filter.startDate=$([datetime]$StartDate)" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No MetadataHistory found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Metadata.History[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}