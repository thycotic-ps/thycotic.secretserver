function Get-TssSecretTemplate {
    <#
    .SYNOPSIS
    Get a secret template from Secret Server

    .DESCRIPTION
    Get a secret template(s) from Secret Server

    .PARAMETER Id
    Secret template ID to retrieve, accepts an array of IDs

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> Get-TssSecretTemplate -Id 93

    Returns secret associated with the Secret ID, 93

    .NOTES
    Requires New-TssSession session be set
    #>
    [cmdletbinding()]
    param(
        # Return only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("TemplateId")]
        [int[]]
        $Id,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $invokeParams = @{ }
    }

    process {
        . $TestTssSession -Session

        foreach ($template in $Id) {
            $restResponse = $null
            $errorResponse = $null
            $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secret-templates", $template.ToString() -join '/'
            $invokeParams.Uri = $Uri
            $invokeParams.Method = 'GET'
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken

            try {
                $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop
            } catch {
                $errorResponse = $_.ErrorDetails.Message | ConvertFrom-Json
            }

            if ($Raw -and $restResponse) {
                $restResponse
            } elseif ($restResponse) {
                foreach ($fieldDetail in $restResponse.fields) {
                    $fieldType =
                    if ($fieldDetail.isFile) {
                        "File"
                    } elseif ($fieldDetail.isNotes) {
                        "Notes"
                    } elseif ($fieldDetail.isPassword) {
                        "Password"
                    } elseif ($fieldDetail.isUrl) {
                        "URL"
                    } else {
                        "Text"
                    }

                    $history =
                    if ($fieldDetail.historyLength -eq [int]::MaxValue) {
                        "All"
                    } else {
                        $fieldDetail.historyLength
                    }

                    $outTemplate = [pscustomobject]@{
                        TemplatId        = $restResponse.Id
                        TemplateName     = $restResponse.Name
                        FieldName        = $fieldDetail.name
                        SlugName         = $fieldDetail.fieldSlugName
                        Description      = $fieldDetail.description
                        FieldType        = $fieldType
                        Required         = $fieldDetail.isRequired
                        History          = $history
                        Searchable       = $fieldDetail.isIndexable
                        EditRequires     = $fieldDetail.editRequires
                        HideOnView       = $fieldDetail.hideOnView
                        ExposeForDisplay = $fieldDetail.mustEncrypt
                    }
                    $outTemplate
                }
            }

            if ($errorResponse) {
                Write-Warning -Message "Issue retrieving secret [$template]: $($errorResponse.message)"
            }
            if ($restResponse.code) {
                Write-Warning -Message "Issue retrieving secret [$template]: $($restResponse.message)"
            }
        }
    }
}