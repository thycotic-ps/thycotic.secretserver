function Search-TssMetadataSection {
    <#
    .SYNOPSIS
    Search Metadata Field Section that has metadata for a specific item

    .DESCRIPTION
    Search Metadata Field Section that has metadata for a specific item

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Search-TssMetadataSection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadataSection.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadataSection -TssSession $session -ItemId 5

    Return field sections for Item ID 5

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Metadata.FieldSectionSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Item ID to return metadata
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [int]
        $ItemId,

        # Metadata Field ID
        [Parameter(ParameterSetName = 'field')]
        [Alias('MetadataSectionFieldId')]
        [int]
        $SectionFieldId,

        # Item Type (Secret, User, Folder, Group)
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [Alias('MetadataType')]
        [Thycotic.PowerShell.Enums.MetadataType]
        $ItemType,

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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'metadata', 'field-sections' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'ItemId' { $filters += "filter.ItemId=$ItemId" }
                'ItemType' { $filters += "filter.metadataType=$ItemType"}
                'SectionFieldId' { $filters += "filter.metadataSectionFilterId=$SectionFieldId"}
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
                Write-Warning "No MetadataSection found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Metadata.FieldSectionSummary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}