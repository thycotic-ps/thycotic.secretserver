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
    [OutputType('TssSecretSummary')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Return only secrets within a certain folder
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "folder")]
        [int[]]
        $FolderId,

        # Include secrets in subfolders of the specified FolderId
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "folder")]
        [Alias('IncludeSubFolder')]
        [switch]
        $IncludeSubFolders,

        # Field to filter on
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "field")]
        [string]
        $Field,

        # Text of the field to filter on
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "field")]
        [string]
        $FieldText,

        # Match the exact text of the FieldText
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "field")]
        [switch]
        $ExactMatch,

        # Field-slug to search
        # This overrides the Field filter
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "field")]
        [string]
        $FieldSlug,

        # Secret Template fields to return
        # Only exposed fields can be returned
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "field")]
        [Alias('ExtendedFields')]
        [string[]]
        $ExtendedField,

        # Return only secrets matching a certain extended type
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "field")]
        [int]
        $ExtendedTypeId,

        # Return only secrets matching a certain template
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [Alias('TemplateId')]
        [int[]]
        $SecretTemplateId,

        # Return only secrets within a certain site
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [int[]]
        $SiteId,

        # Return only secrets with a certain heartbeat status
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [ValidateSet('Failed','Success','Pending','Disabled','UnableToConnect','UnknownError','IncompatibleHost','AccountLockedOut','DnsMismatch','UnableToValidateServerPublicKey','Processing','ArgumentError','AccessDenied')]
        [string]
        $HeartbeatStatus,

        # Include inactive/disabled secrets
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [switch]
        $IncludeInactive,

        # Exclude active secrets
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [switch]
        $ExcludeActive,

        # Secrets where template has RPC Enabled
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [switch]
        $RpcEnabled,

        # Secrets where you are not the owner and secret is explicitly shared with your user
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [switch]
        $SharedWithMe,

        # Secrets matching certain password types
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [int[]]
        $PasswordTypeIds,

        # Filter based on permission (List, View, Edit or Owner)
        [Parameter(ParameterSetName = "filter")]
        [ValidateSet('List','View','Edit','Owner')]
        [string]
        $Permission,

        # Filter All Secrets, Recent or Favorites
        [Parameter(ParameterSetName = "filter")]
        [ValidateSet('All','Recent','Favorites')]
        [string]
        $Scope,

        # Exclude DoubleLocks from search results
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [Alias('ExcludeDoubleLocks')]
        [switch]
        $ExcludeDoubleLock,

        # Include only secrets with a specific DoubleLock ID assigned
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [int]
        $DoubleLockId,

        # Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Search-TssSecret'
        $searchParams = . $GetParams $PSBoundParameters 'Search-TssSecret'
        $invokeParams = @{ }

        $searchParams.Remove('Raw')
        $searchParams.Remove('TssSession')
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            $uri = $TssSession.SecretServer + ( $TssSession.ApiVersion, "secrets" -join '/')
            $uri += "?take=$($TssSession.Take)"
            $uri += "&filter.includeRestricted=true"

            $filters = @()
            $filterEnum = $searchParams.GetEnumerator()
            foreach ($f in $filterEnum) {
                switch ($f.Name) {
                    'Field' {
                        $filters += "filter.searchField=$($f.Value)"
                    }
                    'FieldSlug' {
                        $filters += "filter.searchFieldSlug=$($f.Value)"
                    }
                    'FieldText' {
                        $filters += "filter.searchText=$($f.Value)"
                    }
                    'ExactMatch' {
                        $filters += "filter.isExactmatch=$($f.Value)"
                    }
                    'ExtendedField' {
                        foreach ($v in $f.Value) {
                            $filters += "filter.extendedField=$v"
                        }
                    }
                    'PasswordTypeIds' {
                        foreach ($v in $f.Value) {
                            $filters += "filter.passwordTypeIds=$v"
                        }
                    }
                    'Permission' {
                        $filters += switch ($Permission) {
                            'List' { "filter.permissionRequired=1" }
                            'View' { "filter.permissionRequired=2" }
                            'Edit' { "filter.permissionRequired=3" }
                            'Owner' { "filter.permissionRequired=4" }
                        }
                    }
                    'Scope' {
                        $filters += switch ($Permission) {
                            'All' { "filter.scope=1" }
                            'Recent' { "filter.scope=2" }
                            'Favorit' { "filter.scope=3" }
                        }
                    }
                    'RpcEnabled' {
                        $filters += "filter.onlyRPCEnabled=$($f.Value)"
                    }
                    'SharedWithMe' {
                        $filters += "filter.onlySharedWithMe=$($f.Value)"
                    }
                    'ExcludeDoubleLock' {
                        $filters += "filter.allowDoubleLocks=$($f.Value)"
                    }
                    'ExcludeActive' {
                        $filters += "filter.includeActive=$($f.Value)"
                    }
                    default {
                        $filters += "filter.$($f.name)=$($f.Value)"
                    }
                }
            }
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

            if ($tssParams['Raw']) {
                return $restResponse
            }
            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No secrets found"
            }
            if ($restResponse.records) {
                . $GetTssSecretSummaryObject $restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}