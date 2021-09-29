function Update-TssMetadataField {
    <#
    .SYNOPSIS
    Update metadata field for an item

    .DESCRIPTION
    Update metadata field for an item

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadata -TssSession -ItemId 5 -ItemType User
    Update-TssMetadataField -TssSession $session -ItemId 5 -ItemType User -ItemDataId 5 -FieldValue 2

    Review output from search command to identify the sequence ID of the metadata field (5 as ItemDataId for this example)
    Update the value to 2

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadata -TssSession -ItemId 5 -ItemType User
    Update-TssMetadataField -TssSession $session -ItemId 5 -ItemType User -ItemDataId 5 -FieldValue 2

    Review output from search command to identify the sequence ID of the metadata field (5 as ItemDataId for this example)
    Update the value to 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Update-TssMetadataField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Update-TssMetadataField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [OutputType('Thycotic.PowerShell.Folders.Folder')]
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Item ID
        [Parameter(Mandatory)]
        [int]
        $ItemId,

        # Item Type
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.MetadataType]
        $ItemType,

        # Item Value
        [Parameter(Mandatory)]
        [int]
        $ItemDataId,

        # Field Data Type
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.Enums.MetadataFieldDataType]
        $FieldDataType,

        # Item Value
        [Parameter(Mandatory)]
        [object]
        $FieldValue
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'metadata', $ItemType, $ItemId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $updateBody = @{data = @{} }
            switch ($updateParams.Keys) {
                'ItemDataId' { $updateBody.data.Add('metadataItemDataId', $ItemDataId) }
                'FieldValue' {
                    switch ($FieldDataType) {
                        'String' {
                            $stringValue = @{
                                dirty = $true
                                value = $FieldValue
                            }
                            $updateBody.data.Add('valueString', $stringValue)
                        }
                        'Boolean' {
                            $bitValue = @{
                                dirty = $true
                                value = [boolean]$FieldValue
                            }
                            $updateBody.data.Add('valueBit', $bitValue)
                        }
                        'Number' {
                            $numValue = @{
                                dirty = $true
                                value = $FieldValue
                            }
                            $updateBody.data.Add('valueNumber', $numValue)
                        }
                        'DateTime' {
                            $dtValue = @{
                                dirty = $true
                                value = $FieldValue
                            }
                            $updateBody.data.Add('valueDateTime', $dtValue)
                        }
                        'User' {
                            $userValue = @{
                                dirty = $true
                                value = $FieldValue
                            }
                            $updateBody.data.Add('valueInt', $userValue)
                        }
                    }
                }
            }

            $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 50
            if ($PSCmdlet.ShouldProcess("Item ID: $ItemId", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue updating metadata field on Item ID [$ItemId]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Metadata.Field]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}