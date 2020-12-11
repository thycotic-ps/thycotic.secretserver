function Get-TssSecretTemplate {
    <#
    .SYNOPSIS
    Get a secret template from Secret Server

    .DESCRIPTION
    Get a secret template(s) from Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Id
    Secret template ID to retrieve, accepts an array of IDs

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecretTemplate -Id 93

    Returns secret associated with the Secret ID, 93

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,ValueFromPipeline)]
        [TssSession]$TssSession,

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
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssSecretTemplate'
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($template in $Id) {
                $restResponse = $null
                $errorResponse = $null
                $uri = $TssSession.SecretServerUrl + ($TssSession.ApiVersion, "secret-templates", $template.ToString() -join '/')
                $invokeParams.Uri = $Uri
                $invokeParams.Method = 'GET'
                $invokeParams.PersonalAccessToken = $TssSession.AccessToken

                Write-Verbose "$($invokeParas.Method) $uri with $body"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop -ErrorVariable err
                } catch {
                    $apiError = $err | ConvertFrom-Json
                    if ($apiError.errorCode) {
                        throw "$($apiError.errorCode): $($apiError.message)"
                    } elseif ($apiError.message) {
                        throw $apiError.message
                    } else {
                        throw $err
                    }
                }

                if ($Raw) {
                    return $restResponse
                }
                if ($restResponse) {
                    $outTemplate = [pscustomobject]@{
                        PSTypeName = 'TssSecretTemplate'
                        Id         = $restResponse.id
                        Name       = $restResponse.name
                    }

                    $fields = foreach ($field in $restResponse.fields) {
                        [pscustomobject]@{
                            PSTypeName                   = 'TssSecretTemplateField'
                            SecretTempalteFieldId        = $field.secretTempalteFieldId
                            IsExpirationField            = $field.isExpirationField
                            DisplayName                  = $field.displayName
                            Description                  = $field.description
                            Name                         = $field.name
                            HistoryLength                = $field.historyLength
                            FieldSlugName                = $field.fieldSlugName
                            IsIndexable                  = $field.isIndexable
                            EditRequires                 = $field.editRequires
                            HideOnView                   = $field.hideOnView
                            MustEncrypt                  = $field.mustEncrypt #ExposeForDisplay
                            GeneratePasswordCharacterSet = $field.generatePasswordCharacterSet
                            GeneratePasswordLength       = $field.generatePasswordLength
                            PasswordTypeFieldId          = $field.passwordTypeFieldId
                            PasswordRequirementId        = $field.passwordRequirementId
                            SortOrder                    = $field.sortOrder
                            EditablePermission           = $field.editablePermission
                            IsFile                       = $field.isFile
                            IsNotes                      = $field.isNotes
                            IsPassword                   = $field.isPassword
                            IsUrl                        = $field.isUrl
                            IsRequired                   = $field.isRequired
                        }
                    }
                    $outTemplate.PSObject.Properties.Add([PSNoteProperty]::new('Fields',$fields))
                    $outTemplate
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}