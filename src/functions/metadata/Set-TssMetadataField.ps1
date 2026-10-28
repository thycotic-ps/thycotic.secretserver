function Set-TssMetadataField {
    <#
    .SYNOPSIS
    Rename or disable a metadata field definition

    .DESCRIPTION
    Rename or disable a metadata field definition (PATCH metadata/fields/{id}).
    Only the parameters you give are sent; omitted settings stay unchanged.
    A disabled field keeps its values on items, and Search-TssMetadata still returns them. Secret Server rejects enabling it again.
    Requires the Administer Metadata permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Metadata field ID

    .PARAMETER Enabled
    Disable the field with -Enabled:$false; omit to leave it unchanged. A disabled field cannot be enabled again

    .PARAMETER FieldName
    New name for the metadata field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssMetadataField -TssSession $session -Id 12 -FieldName 'CostCenter'

    Rename metadata field 12 to CostCenter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMetadataField -TssSession $session | Where-Object MetadataFieldName -eq 'DeleteMeOn' | Set-TssMetadataField -TssSession $session -Enabled:$false

    Disable the metadata field named DeleteMeOn, found with Get-TssMetadataField

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Set-TssMetadataField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Set-TssMetadataField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Metadata.FieldSummary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FieldId', 'MetadataFieldId')]
        [int]
        $Id,

        [switch]
        $Enabled,

        [string]
        $FieldName
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
            $uri = $TssSession.ApiUrl, 'metadata', 'fields', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'FieldName' {
                    $body.data.Add('metadataFieldName', @{ dirty = $true; value = $FieldName })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Metadata field: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssMetadataField request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Metadata.FieldSummary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Metadata.FieldSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
