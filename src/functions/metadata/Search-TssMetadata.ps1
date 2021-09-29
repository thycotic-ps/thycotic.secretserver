function Search-TssMetadata {
    <#
    .SYNOPSIS
    Search metadata

    .DESCRIPTION
    Search metadata

    When searching based on Item ID the account used must have the proper permissions on that object before metadata data can be returned

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssMetadata

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-TssMetadata.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadata -TssSession $session -ItemId 46 -MetadataFieldId 4

    Return Field ID 4 on object Item ID 46

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Metadata.Summary')]
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
        [int]
        $FieldId,

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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'metadata' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'ItemId' { $filters += "filter.itemId=$ItemId" }
                'FieldId' { $filters += "filter.metaDataFieldId=$FieldId" }
                'ItemType' { $filters += "filter.metadataType=$ItemType" }
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
                Write-Warning "No Metadata found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Metadata.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}