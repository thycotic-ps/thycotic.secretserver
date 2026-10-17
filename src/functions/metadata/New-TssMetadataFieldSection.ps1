function New-TssMetadataFieldSection {
    <#
    .SYNOPSIS
    Create a metadata field section

    .DESCRIPTION
    Create a metadata field section (POST metadata/field-sections).
    Add field definitions to the section with New-TssMetadataField -SectionId.
    Requires the Administer Metadata permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SectionName
    Name of the metadata field section

    .PARAMETER SectionDescription
    Description of the metadata field section

    .PARAMETER RequireAdminister
    Require the Administer Metadata permission to modify metadata in this section

    .PARAMETER RequireItemEdit
    Require Edit permission on the item to modify metadata in this section

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssMetadataFieldSection -TssSession $session -SectionName 'Ownership' -SectionDescription 'Who owns the item'

    Create the metadata field section Ownership

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $section = New-TssMetadataFieldSection -TssSession $session -SectionName 'Compliance' -RequireAdminister
    New-TssMetadataField -TssSession $session -SectionId $section.MetadataFieldSectionId -FieldName 'ReviewedOn' -FieldDataType DateTime

    Create the section Compliance that only users with Administer Metadata can change, then add a DateTime field to it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/metadata/New-TssMetadataFieldSection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/metadata/New-TssMetadataFieldSection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Metadata.FieldSectionSummary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $SectionName,

        [string]
        $SectionDescription,

        [switch]
        $RequireAdminister,

        [switch]
        $RequireItemEdit
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
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'SectionDescription' {
                    $body.data.Add('metadataFieldSectionDescription', $SectionDescription)
                }
                'SectionName' {
                    $body.data.Add('metadataFieldSectionName', $SectionName)
                }
                'RequireAdminister' {
                    $body.data.Add('requiresAdministerMetadata', [boolean]$RequireAdminister)
                }
                'RequireItemEdit' {
                    $body.data.Add('requiresEntityEdit', [boolean]$RequireItemEdit)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Metadata field section", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssMetadataFieldSection request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Metadata.FieldSectionSummary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Metadata.FieldSectionSummary]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
