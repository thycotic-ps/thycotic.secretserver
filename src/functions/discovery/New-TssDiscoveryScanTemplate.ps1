function New-TssDiscoveryScanTemplate {
    <#
    .SYNOPSIS
    Create a Discovery scan template

    .DESCRIPTION
    Creates a Discovery scan template and returns it. With CreateDefaultFields and no Fields, the template takes its fields from the parent template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AccountScanId
    Deprecated, use AccountScanIds. Account scan template id for a dependency template (scan type 4)

    .PARAMETER AccountScanIds
    Account scan template ids, for a dependency template (scan type 4)

    .PARAMETER CreateDefaultFields
    Copy the fields of the parent template when Fields is not given. The server rejects a template without fields, so give CreateDefaultFields with ParentScanTemplateId, or Fields

    .PARAMETER Fields
    Template fields: hashtables or objects with scanItemFieldName, parentScanItemFieldId and includeInMatch (include the field when matching scanned items)

    .PARAMETER IsActive
    Create the template active. Without it the template is created inactive

    .PARAMETER ParentScanTemplateId
    Parent scan template id

    .PARAMETER ScanTemplateName
    Template name

    .PARAMETER ScanTypeId
    Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoveryScanTemplate -TssSession $session -ScanTemplateName 'Local Account (custom)' -ScanTypeId 3 -ParentScanTemplateId 1 -CreateDefaultFields -IsActive

    Create an active local account scan template that copies the fields of template 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoveryScanTemplate -TssSession $session -ScanTemplateName 'Local Account (two fields)' -ScanTypeId 3 -ParentScanTemplateId 1 -IsActive -Fields @{ scanItemFieldName = 'Username'; parentScanItemFieldId = 1; includeInMatch = $true }, @{ scanItemFieldName = 'Machine'; parentScanItemFieldId = 2; includeInMatch = $true }

    Create an active local account scan template with two fields

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryScanTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryScanTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.ScanTemplate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $AccountScanId,

        [int[]]
        $AccountScanIds,

        [switch]
        $CreateDefaultFields,

        [object[]]
        $Fields,

        [switch]
        $IsActive,

        [int]
        $ParentScanTemplateId,

        [Parameter(Mandatory)]
        [string]
        $ScanTemplateName,

        [Parameter(Mandatory)]
        [int]
        $ScanTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scan-templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AccountScanId' {
                    $body.data.Add('accountScanId', $AccountScanId)
                }
                'AccountScanIds' {
                    $body.data.Add('accountScanIds', $AccountScanIds)
                }
                'CreateDefaultFields' {
                    $body.data.Add('createDefaultFields', [boolean]$CreateDefaultFields)
                }
                'Fields' {
                    $body.data.Add('fields', $Fields)
                }
                'IsActive' {
                    $body.data.Add('isActive', [boolean]$IsActive)
                }
                'ParentScanTemplateId' {
                    $body.data.Add('parentScanTemplateId', $ParentScanTemplateId)
                }
                'ScanTemplateName' {
                    $body.data.Add('scanTemplateName', $ScanTemplateName)
                }
                'ScanTypeId' {
                    $body.data.Add('scanTypeId', $ScanTypeId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery scan template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoveryScanTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.ScanTemplate](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.ScanTemplate]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
