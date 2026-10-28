function Remove-TssMetadataFieldSection {
    <#
    .SYNOPSIS
    Disable a metadata field section definition

    .DESCRIPTION
    Disable a metadata field section definition (DELETE metadata/field-sections/{id}).
    Every field in the section is disabled too. Values already set on items are kept, and Search-TssMetadata still returns them.
    This cannot be undone.
    Requires the Administer Metadata permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Metadata field section ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssMetadataFieldSection -TssSession $session -Id 3

    Disable metadata field section 3 and its fields

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMetadataSection -TssSession $session | Where-Object MetadataFieldSectionName -eq 'Ownership' | Remove-TssMetadataFieldSection -TssSession $session -WhatIf

    Show that the metadata field section Ownership would be disabled, without disabling it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/Remove-TssMetadataFieldSection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/Remove-TssMetadataFieldSection.ps1

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
        [Alias('FieldSectionId', 'MetadataFieldSectionId')]
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
                $uri = $TssSession.ApiUrl, 'metadata', 'field-sections', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Metadata field section: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssMetadataFieldSection request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.success) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $currentId
                            ObjectType = 'MetadataFieldSection'
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
