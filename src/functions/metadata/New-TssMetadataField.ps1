function New-TssMetadataField {
    <#
    .SYNOPSIS
    Create a metadata field for an item

    .DESCRIPTION
    Create a metadata field for an item

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newMetaParams = @{
        TssSession = $session
        ItemId = 5
        ItemType = 'User'
        SectionId = 1
        FieldName = 'DeleteMeOn'
        FieldDataType = 'DateTime'
        FieldValue = '2021-12-31 11:59:59 PM'
    }
    New-TssMetadataField @newMetaParams

    Create the metadata field DeleteMeOn with a DateTime value of December 31, 2021 11:59:59 PM on User ID 5, in current Field Section ID 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newMetaParams = @{
        TssSession = $session
        ItemId = 5
        ItemType = 'User'
        SectionName = 'TempInfo'
        SectionDescription = 'Information that is temporary'
        FieldName = 'CurrentOwner'
        FieldDataType = 'User'
        FieldValue = 6
    }
    New-TssMetadataField @newMetaParams

    Create the metadata field CurrentOwner with a User ID set to 6, under new section called "TempInfo" (with a description)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/New-TssMetadataField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/New-TssMetadataField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Metadata.Field')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Item ID
        [Parameter(Mandatory, ParameterSetName = 'currentsection')]
        [Parameter(Mandatory, ParameterSetName = 'newsection')]
        [int]
        $ItemId,

        # Item Type
        [Parameter(Mandatory, ParameterSetName = 'currentsection')]
        [Parameter(Mandatory, ParameterSetName = 'newsection')]
        [Thycotic.PowerShell.Enums.MetadataType]
        $ItemType,

        # Field Section ID
        [Parameter(ParameterSetName = 'currentsection')]
        [int]
        $SectionId,

        # Field Section Name
        [Parameter(ParameterSetName = 'newsection')]
        [string]
        $SectionName,

        # Field Section Description
        [Parameter(ParameterSetName = 'newsection')]
        [string]
        $SectionDescription,

        # Field Name
        [Parameter(Mandatory, ParameterSetName = 'currentsection')]
        [Parameter(Mandatory, ParameterSetName = 'newsection')]
        [string]
        $FieldName,

        # Field Data Type
        [Parameter(Mandatory, ParameterSetName = 'currentsection')]
        [Parameter(Mandatory, ParameterSetName = 'newsection')]
        [Thycotic.PowerShell.Enums.MetadataFieldDataType]
        $FieldDataType,

        # Item Value
        [Parameter(Mandatory, ParameterSetName = 'currentsection')]
        [Parameter(Mandatory, ParameterSetName = 'newsection')]
        [object]
        $FieldValue,

        # Requires Administer Metadata permission to modify
        [Parameter(ParameterSetName = 'currentsection')]
        [Parameter(ParameterSetName = 'newsection')]
        [switch]
        $RequireAdminister,

        # Requires Edit permission on the Item to modify
        [Parameter(ParameterSetName = 'currentsection')]
        [Parameter(ParameterSetName = 'newsection')]
        [switch]
        $RequireItemEdit
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'metadata', $ItemType, $ItemId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $newBody = @{data = @{} }
            switch ($tssNewParams.Keys) {
                'FieldDataType' { $newBody.data.Add('fieldDataType',[string]$FieldDataType) }
                'FieldValue' {
                    switch ($FieldDataType) {
                        'String' { $newBody.data.Add('valueString', $FieldValue) }
                        'Boolean' { $newBody.data.Add('valueBit',[boolean]$FieldValue) }
                        'Number' { $newBody.data.Add('valueNumber',$FieldValue) }
                        'DateTime' { $newBody.data.Add('valueDateTime',[datetime]$FieldValue) }
                        'User' { $newBody.data.Add('valueInt',[int]$FieldValue) }
                    }
                }
                'FieldName' { $newBody.data.Add('metadataFieldName',$FieldName) }
                'SectionId' { $newBody.data.Add('metadataFieldSectionId',$SectionId) }
                'SectionName' { $newBody.data.Add('metadataFieldSectionName',$SectionName) }
                'SectionDescription' { $newBody.data.Add('metadataFieldSectionDescription',$SectionDescription) }
                'RequireAdminister' { $newBody.data.Add('metadataFieldSectionRequiresAdministerMetadata',[boolean]$RequireAdminister) }
                'RequireItemEdit' { $newBody.data.Add('metadataFieldSectionRequiresEntityEdit',[boolean]$RequireItemEdit) }
            }

            $invokeParams.Body = ($newBody | ConvertTo-Json -Depth 10)

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)`n"
            if (-not $PSCmdlet.ShouldProcess("Item ID: $ItemId", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)`n")) { return }
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue creating Metadata Field on Item [$ItemId]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Metadata.Field]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}