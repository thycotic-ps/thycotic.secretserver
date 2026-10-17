function Remove-TssMetadataField {
    <#
    .SYNOPSIS
    Disable a metadata field definition

    .DESCRIPTION
    Disable a metadata field definition (DELETE metadata/fields/{id}).
    Values already set on items are kept, and Search-TssMetadata still returns them.
    This cannot be undone.
    Requires the Administer Metadata permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Metadata field ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssMetadataField -TssSession $session -Id 12

    Disable metadata field 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMetadataField -TssSession $session | Where-Object MetadataFieldName -eq 'DeleteMeOn' | Remove-TssMetadataField -TssSession $session -Confirm:$false

    Disable the metadata field named DeleteMeOn without a confirmation prompt

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Remove-TssMetadataField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Remove-TssMetadataField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FieldId', 'MetadataFieldId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'metadata', 'fields', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Metadata field: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssMetadataField request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.success) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $currentId
                            ObjectType = 'MetadataField'
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
