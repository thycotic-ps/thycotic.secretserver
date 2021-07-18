function Search-Metadata {
    <#
    .SYNOPSIS
    Search metadata

    .DESCRIPTION
    Search metadata

    When searching based on Item ID the account used must have the proper permissions on that object before metadata data can be returned

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssMetadata

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Search-Metadata.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadata -TssSession $session -ItemId 46 -MetadataFieldId 4

    Return Field ID 4 on object Item ID 46

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssMetadataSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Item ID to return metadata (Secret, Group, User, etc.)
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [int]
        $ItemId,

        # Metadata Field ID
        [Parameter(ParameterSetName = 'field')]
        [int]
        $FieldId,

        # Metadata Type (Secret, User, Folder, Group)
        [Parameter(Mandatory, ParameterSetName = 'item')]
        [ValidateSet('Secret','User','Folder','Group')]
        [string]
        $Type,

        # Sort by specific property, default ItemId
        [string]
        $SortBy = 'ItemId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'metadata' -join '/'
            $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'ItemId' { $filters += "filter.itemId=$ItemId" }
                'FieldId' { $filters += "filter.metaDataFieldId=$FieldId" }
                'Type' { $filters += "filter.metadataType=$Type" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No Metadata found"
            }
            if ($restResponse.records) {
                [TssMetadataSummary[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}