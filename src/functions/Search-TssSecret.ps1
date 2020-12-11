function Search-TssSecret {
    <#
    .SYNOPSIS
    Search for a secret

    .DESCRIPTION
    Search for secrets using various filters provided by each parameter

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER FolderId
    Folder ID to search, allows multiple

    .PARAMETER SecretTemplateId
    Template ID to search, allows multiple

    .PARAMETER SiteId
    Site ID to filter on, allows multiple

    .PARAMETER HeartbeatStatus
    Heartbeat status to filter on

    .PARAMETER SearchField
    Field to filter on

    .PARAMETER SearchText
    Field value to filter on

    .PARAMETER SearchSlug
    Slug name of field to filter on

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssSecret -TssSession $session -FolderId 50

    Will return all secrets found with a folder ID of 50

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssSecret -TssSession $session -FolderId 50 -SecretTemplateId 6001

    Will return all secrets using Secret Template 6001 that are found in FolderID 50.

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = "filter")]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,ValueFromPipeline)]
        [TssSession]$TssSession,

        # Return only secrets within a certain folder
        [Parameter(ParameterSetName = "filter")]
        [int[]]
        $FolderId,

        # Return only secrets matching a certain template
        [Parameter(ParameterSetName = "filter")]
        [Alias('TemplateId')]
        [int[]]
        $SecretTemplateId,

        # Return only secrets within a certain site
        [Parameter(ParameterSetName = "filter")]
        [int[]]
        $SiteId,

        # Return only secrets with a certain heartbeat status
        [Parameter(ParameterSetName = "filter")]
        [ValidateSet('Pending','Disabled','Success','Failed','UnableToConnect','IncompatibleHost','UnknownError','ArgumentError')]
        [string]
        $HeartbeatStatus,

        [Parameter(ParameterSetName = "field")]
        [string]
        $SearchField,

        # Search text value for field
        [Parameter(ParameterSetName = "field")]
        [string]
        $SearchText,

        # Field-slug to search. This will override SearchField.
        [Parameter(ParameterSetName = "field")]
        [string]
        $SearchSlug,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $invokeParams = @{ }

        $Parameters = @{ } + $PSBoundParameters
        $Parameters.Remove('Raw')
        $filterParams = . $GetSearchSecretParams $Parameters
    }

    process {
        if ($filterParams.Contains('TssSession') -and $TssSession.IsValidSession()) {

            $uri = $TssSession.SecretServerUrl + ( $TssSession.ApiVersion, "secrets" -join '/')
            $uri += "?take=$($TssSession.Take)&filter.includeInactive=true&filter.includeRestricted=true"

            $filters = $filterParams.GetEnumerator() | ForEach-Object { "filter.$($_.name)=$($_.value)" }
            $uriFilter = $filters -join "&"
            Write-Verbose "Filters: $uriFilter"

            $uri = $uri, $uriFilter -join "&"

            $invokeParams.Uri = $uri
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            $invokeParams.Method = 'GET'
            if (-not $Raw) {
                $invokeParams.ExpandProperty = 'records'
            }

            try {
                $restResponse = Invoke-TssRestApi @invokeParams -ErrorAction Stop
            } catch {
                Write-Error -TargetObject $Uri -Category InvalidOperation -Message "Unable to search for secrets: $($_.Exception)"
            }

            if ($restResponse) {
                foreach ($record in $restResponse) {
                    $output = [PSCustomObject]@{
                        SecretId              = $record.id
                        SecretName            = $record.name
                        TemplateId            = $record.secretTemplateId
                        TemplateName          = $record.secretTemplateName
                        FolderId              = if ($record.folderId -eq -1) { $null } else { $record.folderId }
                        SiteId                = $record.siteId
                        Active                = $record.active
                        CheckedOut            = $record.checkedOut
                        Restricted            = $record.isRestricted
                        OutOfSync             = $record.isOutOfSync
                        HeartbeatStatus       = $record.lastHeartBeatStatus
                        PasswordChangeAttempt = [datetime]$record.lastPasswordChangeAttempt
                        LastAccessed          = if ($record.lastAccessed) { [datetime]$record.lastAccessed } else { [datetime]"0001-01-01T00:00" }
                        CheckoutEnabled       = $record.CheckoutEnabled
                        AutoChangeEnabled     = $record.AutoChangeEnabled
                        DoubleLockEnabled     = $record.doubleLockEnabled
                        RequiresApproval      = $record.requiresApproval
                        RequiresComment       = $record.requiresComment
                        InheritsPermissions   = $record.inheritsPermissions
                        PasswordHidden        = $record.hidePassword
                        CreateDate            = [datetime]$record.createDate
                        ExpirationDays        = $record.daysUntilExpiration
                        ExpirationDate        = if ($record.daysUntilExpiration) { [datetime]::UtcNow.AddDays($record.daysUntilExpiration) } else { $null }
                    }
                    $properties = $output.PSObject.Properties | Sort-Object Name
                    $final = [PSCustomObject]@{ }
                    foreach ($prop in $properties) {
                        $final.PSObject.Properties.Add([PSNoteProperty]::new($prop.Name,$prop.Value))
                    }
                    $final
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}