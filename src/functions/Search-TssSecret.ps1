function Search-TssSecret {
    <#
    .SYNOPSIS
    Search for a secret

    .DESCRIPTION
    Search for secrets using various filters provided by each parameter

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssSecret -TssSession $session -FolderId 50

    Return all secrets found with a folder ID of 50

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssSecret -TssSession $session -FolderId 50 -SecretTemplateId 6001

    Return all secrets using Secret Template 6001 that are found in FolderID 50.

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Search-TssSecret -TssSession $session -SecretTemplateId 6047 -IncludeInactive

    Return all secrets using Secret Template 6047 that are active **and** inactive.

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = "filter")]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
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
        [ValidateSet({'Failed','Success','Pending','Disabled','UnableToConnect','UnknownError','IncompatibleHost','AccountLockedOut','DnsMismatch','UnableToValidateServerPublicKey','Processing','ArgumentError','AccessDenied'})]
        [string]
        $HeartbeatStatus,

        # Search text of a specific field
        [Parameter(ParameterSetName = "field")]
        [string]
        $SearchField,

        # Search text of the provided field
        [Parameter(ParameterSetName = "field")]
        [string]
        $SearchText,

        # Field slug to search
        # This overrides the SearchField
        [Parameter(ParameterSetName = "field")]
        [string]
        $SearchSlug,

        # Include inactive/disabled secrets
        [Parameter(ParameterSetName = "field")]
        [Parameter(ParameterSetName = "filter")]
        [switch]
        $IncludeInactive,

        # Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $invokeParams = @{ }

        $Parameters = @{ } + $PSBoundParameters
        $Parameters.Remove('Raw')
        $searchParams = . $GetSearchSecretParams $Parameters
    }

    process {
        if ($searchParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            $uri = $TssSession.SecretServer + ( $TssSession.ApiVersion, "secrets" -join '/')
            $uri += "?take=$($TssSession.Take)"
            if ($searchParams.Contains('IncludeInactive')) {
                $uri += "&filter.includeInactive=true"
            }
            $uri += "&filter.includeRestricted=true"

            $filters = $searchParams.GetEnumerator() | ForEach-Object { "filter.$($_.name)=$($_.value)" }
            $uriFilter = $filters -join "&"
            Write-Verbose "Filters: $uriFilter"

            $uri = $uri, $uriFilter -join "&"

            $invokeParams.Uri = $uri
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            $invokeParams.Method = 'GET'

            Write-Verbose "$($invokeParams.Method) $uri with $body"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_.ErrorDetails.Message
                Write-Error $err
            }

            if ($searchParams['Raw']) {
                return $restResponse
            }
            if ($restResponse.Records.Count -le 0 -and $restResponse.Records.Length -eq 0) {
                Write-Warning "No secrets found"
            }
            if ($restResponse.records) {
                foreach ($record in $restResponse.records) {
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