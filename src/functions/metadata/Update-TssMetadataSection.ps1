function Update-TssMetadataSection {
    <#
    .SYNOPSIS
    Update metadata field section

    .DESCRIPTION
    Update metadata field section

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadata -TssSession -ItemId 5 -ItemType User
    Update-TssMetadataSection -TssSession $session -SectionId 5 -ItemType User -ItemDataId 5 -FieldValue 2

    Review output from search command to identify the sequence ID of the metadata field (5 as ItemDataId for this example)
    Update the value to 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadata -TssSession -ItemId 5 -ItemType User
    Update-TssMetadataSection -TssSession $session -ItemId 5 -ItemType User -ItemDataId 5 -FieldValue 2

    Review output from search command to identify the sequence ID of the metadata field (5 as ItemDataId for this example)
    Update the value to 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssMetadataSection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssMetadataSection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.Metadata.FieldSectionSummary')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Field Section ID
        [Parameter(Mandatory)]
        [Alias('FieldSectionId')]
        [int]
        $SectionId,

        # Item ID
        [Parameter(Mandatory)]
        [int]
        $ItemId,

        # Item Type
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.MetadataType]
        $ItemType,

        # Field Section Name
        [string]
        $Name,

        # Field Section description
        [string]
        $Description,

        # Requires Administer Metadata permission to modify
        [switch]
        $RequireAdminister,

        # Requires Edit permission on the Item to modify
        [switch]
        $RequireItemEdit
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'metadata', 'field-sections', $SectionId -join '/'
            if ($updateParams.ContainsKey('ItemId') -and $updateParams.ContainsKey('ItemType')) {
                $uri = $uri, "itemId=$ItemId&itemType=$ItemType" -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $updateBody = @{data = @{} }
            switch ($updateParams.Keys) {
                'Name' {
                    $nameUpdate = @{
                        dirty = $true
                        value = $Name
                    }
                    $updateBody.data.Add('metadataFieldSectionName',$nameUpdate)
                }
                'Description' {
                    $descUpdate = @{
                        dirty = $true
                        value = $Description
                    }
                    $updateBody.data.Add('metadataFieldSectionDescription',$descUpdate)
                }
                'RequireAdminister' {
                    $requireAdminUpdate = @{
                        dirty = $true
                        value = [boolean]$RequireAdminister
                    }
                    $updateBody.data.Add('metadataFieldSectionRequiresAdministerMetadata',$requireAdminUpdate)
                }
                'RequireItemEdit' {
                    $requireItemEditUpdate = @{
                        dirty = $true
                        value = [boolean]$RequireItemEdit
                    }
                    $updateBody.data.Add('metadataFieldSectionRequiresEntityEdit',$requireItemEditUpdate)
                }
            }

            $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 50
            if ($PSCmdlet.ShouldProcess("Item ID: $ItemId", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating metadata section [$SectionId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Metadata.FieldSectionSummary]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}