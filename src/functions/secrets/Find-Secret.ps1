function Find-Secret {
    <#
    .SYNOPSIS
    Find a secret

    .DESCRIPTION
    Find secrets using the filter parameters provided

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -FolderId 50 -RpcEnabled

    Return secrets found in folder 50 where RPC is enabled on the secret templates

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Find-TssSecret

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = "filter")]
    [OutputType('TssSecretLookup')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret ID to retrieve
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [Alias("SecretId")]
        [int]
        $Id,

        # Return only secrets within a certain folder
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "folder")]
        [int]
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
        [int]
        $SecretTemplateId,

        # Return only secrets within a certain site
        [Parameter(ParameterSetName = "filter")]
        [Parameter(ParameterSetName = "secret")]
        [int]
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
        $DoubleLockId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            if ($tssParams['Id']) {
                $uri = $TssSession.ApiUrl , "secrets/lookup", $Id -join '/'
            } else {
                $uri = $TssSession.ApiUrl, "secrets/lookup" -join '/'
                $uri += "?take=$($TssSession.Take)"
                $uri += "&filter.includeRestricted=true"

                $filters = @()
                switch ($tssParams.Keys) {
                    'Field' {
                        $filters += "filter.searchField=$($tssParams['Field'])"
                    }
                    'FieldSlug' {
                        $filters += "filter.searchFieldSlug=$($tssParams['FieldSlug'])"
                    }
                    'FieldText' {
                        $filters += "filter.searchText=$($tssParams['FieldText'])"
                    }
                    'ExactMatch' {
                        $filters += "filter.isExactmatch=$($tssParams['ExactMatch'])"
                    }
                    'ExtendedField' {
                        foreach ($v in $tssParams['ExtendedField']) {
                            $filters += "filter.extendedField=$v"
                        }
                    }
                    'PasswordTypeIds' {
                        foreach ($v in $tssParams['PasswordTypeIds']) {
                            $filters += "filter.passwordTypeIds=$v"
                        }
                    }
                    'Permission' {
                        $filters += switch ($tssParams['Permission']) {
                            'List' { "filter.permissionRequired=1" }
                            'View' { "filter.permissionRequired=2" }
                            'Edit' { "filter.permissionRequired=3" }
                            'Owner' { "filter.permissionRequired=4" }
                        }
                    }
                    'Scope' {
                        $filters += switch ($tssParams['Scope']) {
                            'All' { "filter.scope=1" }
                            'Recent' { "filter.scope=2" }
                            'Favorite' { "filter.scope=3" }
                        }
                    }
                    'RpcEnabled' {
                        $filters += "filter.onlyRPCEnabled=$($tssParams['RpcEnabled'])"
                    }
                    'SharedWithMe' {
                        $filters += "filter.onlySharedWithMe=$($tssParams['SharedWithMe'])"
                    }
                    'ExcludeDoubleLock' {
                        $filters += "filter.allowDoubleLocks=$($tssParams['ExcludeDoubleLock'])"
                    }
                    'ExcludeActive' {
                        $filters += "filter.includeActive=$($tssParams['ExcludeActive'])"
                    }
                    default {
                        if ($_ -in 'Verbose','TssSession','Raw') { continue } else {
                            $filters += "filter.$($_)=$($tssParams[$_])"
                        }
                    }
                }
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }


            $invokeParams.Uri = $uri
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            $invokeParams.Method = 'GET'
            Write-Verbose "$($invokeParams.Method) $uri"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($tssParams['Id']) {
                . $TssSecretLookupObject $restResponse -IsId
            } else {
                if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                    Write-Warning "No secrets found"
                }
                if ($restResponse) {
                    . $TssSecretLookupObject $restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}