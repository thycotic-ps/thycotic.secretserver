function Set-TssDiscoveryScanTemplate {
    <#
    .SYNOPSIS
    Update a Discovery scan template

    .DESCRIPTION
    Updates the given fields of a Discovery scan template and returns the updated template. Fields not given are unchanged. Fields replaces every field of the template. Use it on templates you created: the server does not stop changes to built-in templates.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Scan template id

    .PARAMETER AccountScanId
    Deprecated, use AccountScanIds. Account scan template id for a dependency template (scan type 4)

    .PARAMETER AccountScanIds
    Account scan template ids, for a dependency template (scan type 4)

    .PARAMETER Fields
    Every field of the template (replaces the current fields): hashtables or objects with scanItemFieldId (omit for a new field), scanItemFieldName, parentScanItemFieldId and includeInMatch

    .PARAMETER IsActive
    Activate the template; use -IsActive:$false to deactivate it

    .PARAMETER ParentScanTemplateId
    Parent scan template id

    .PARAMETER ScanTemplateName
    Template name

    .PARAMETER ScanTypeId
    Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryScanTemplate -TssSession $session -Id 31 -ScanTemplateName 'Local Account (renamed)'

    Rename scan template 31

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryScanTemplate -TssSession $session -Id 31 -IsActive:$false

    Deactivate scan template 31

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryScanTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryScanTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.ScanTemplate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScanTemplateId')]
        [int]
        $Id,

        [int]
        $AccountScanId,

        [int[]]
        $AccountScanIds,

        [object[]]
        $Fields,

        [switch]
        $IsActive,

        [int]
        $ParentScanTemplateId,

        [string]
        $ScanTemplateName,

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
            $uri = $TssSession.ApiUrl, 'discovery', 'scan-templates', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AccountScanId' {
                    $body.data.Add('accountScanId', @{ dirty = $true; value = $AccountScanId })
                }
                'AccountScanIds' {
                    $body.data.Add('accountScanIds', @{ dirty = $true; value = $AccountScanIds })
                }
                'Fields' {
                    $body.data.Add('fields', @{ dirty = $true; value = $Fields })
                }
                'IsActive' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$IsActive })
                }
                'ParentScanTemplateId' {
                    $body.data.Add('parentScanTemplateId', @{ dirty = $true; value = $ParentScanTemplateId })
                }
                'ScanTemplateName' {
                    $body.data.Add('scanTemplateName', @{ dirty = $true; value = $ScanTemplateName })
                }
                'ScanTypeId' {
                    $body.data.Add('scanTypeId', @{ dirty = $true; value = $ScanTypeId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery scan template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryScanTemplate request'
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
