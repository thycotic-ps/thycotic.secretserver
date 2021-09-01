function Search-TssSecret {
    <#
    .SYNOPSIS
    Search for a secret

    .DESCRIPTION
    Search for secrets using various filters provided by each parameter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -FolderId 50

    Return all secrets found with a folder ID of 50

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -FolderId 50 -SecretTemplateId 6001

    Return all secrets using Secret Template 6001 that are found in FolderID 50.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -SecretTemplateId 6047 -IncludeInactive

    Return all secrets using Secret Template 6047 that are active **and** inactive.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -SecretName 'Azure'

    Return all secrets that have Azure in the name of the Secret (wildcard search)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -SecretName 'Azure Test Account' -ExactMatch

    Return all secret(s) that have the exact name "Azure Test Account"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -Field username -SearchText 'root'

    Return all secret(s) that have the username "root"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = 'filter')]
    [OutputType('Thycotic.PowerShell.Secrets.Summary')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Return only secrets within a certain folder
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'folder')]
        [int]
        $FolderId,

        # Include secrets in subfolders of the specified FolderId
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'folder')]
        [Alias('IncludeSubFolder')]
        [switch]
        $IncludeSubFolders,

        # Field to filter on
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [string]
        $Field,

        # Text of the field to filter on
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [Alias('SecretName')]
        [string]
        $SearchText,

        # Match the exact text of the SearchText
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [switch]
        $ExactMatch,

        # Field-slug to search
        # This overrides the Field filter
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [string]
        $FieldSlug,

        # Secret Template fields to return
        # Only exposed fields can be returned
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [Alias('ExtendedFields')]
        [string[]]
        $ExtendedField,

        # Return only secrets matching a certain extended type
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [int]
        $ExtendedTypeId,

        # Return only secrets matching a certain template
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [Alias('TemplateId')]
        [int]
        $SecretTemplateId,

        # Return only secrets within a certain site
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [int]
        $SiteId,

        # Return only secrets with a certain heartbeat status
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [ValidateSet('Failed', 'Success', 'Pending', 'Disabled', 'UnableToConnect', 'UnknownError', 'IncompatibleHost', 'AccountLockedOut', 'DnsMismatch', 'UnableToValidateServerPublicKey', 'Processing', 'ArgumentError', 'AccessDenied')]
        [string]
        $HeartbeatStatus,

        # Include inactive/disabled secrets
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [switch]
        $IncludeInactive,

        # Exclude active secrets
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [switch]
        $ExcludeActive,

        # Secrets where template has RPC Enabled
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [switch]
        $RpcEnabled,

        # Secrets where you are not the owner and secret is explicitly shared with your user
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [switch]
        $SharedWithMe,

        # Secrets matching certain password types
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [int[]]
        $PasswordTypeIds,

        # Filter based on permission (List, View, Edit or Owner)
        [Parameter(ParameterSetName = 'filter')]
        [ValidateSet('List', 'View', 'Edit', 'Owner')]
        [string]
        $Permission,

        # Filter All Secrets, Recent or Favorites
        [Parameter(ParameterSetName = 'filter')]
        [ValidateSet('All', 'Recent', 'Favorites')]
        [string]
        $Scope,

        # Exclude DoubleLocks from search results
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [Alias('ExcludeDoubleLocks')]
        [switch]
        $ExcludeDoubleLock,

        # Include only secrets with a specific DoubleLock ID assigned
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [int]
        $DoubleLockId,

        # Sort by specific property, default Name
        [string]
        $SortBy = 'Name'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets' -join '/'
            $uri += "?sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)"
            $uri += '&filter.includeRestricted=true'

            $filters = @()
            switch ($tssParams.Keys) {
                'Field' {
                    $filters += "filter.searchField=$($tssParams['Field'])"
                }
                'FieldSlug' {
                    $filters += "filter.searchFieldSlug=$($tssParams['FieldSlug'])"
                }
                'SearchText' {
                    $filters += "filter.searchText=$($tssParams['SearchText'])"
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
                        'List' { 'filter.permissionRequired=1' }
                        'View' { 'filter.permissionRequired=2' }
                        'Edit' { 'filter.permissionRequired=3' }
                        'Owner' { 'filter.permissionRequired=4' }
                    }
                }
                'Scope' {
                    $filters += switch ($tssParams['Scope']) {
                        'All' { 'filter.scope=1' }
                        'Recent' { 'filter.scope=2' }
                        'Favorite' { 'filter.scope=3' }
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
                    if ($_ -in 'Verbose', 'TssSession', 'Raw') { continue } else {
                        $filters += "filter.$($_)=$($tssParams[$_])"
                    }
                }
            }

            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }

            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue on search request'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning 'No secrets found'
            }

            if ($restResponse.records) {
                [Thycotic.PowerShell.Secrets.Summary[]]$restResponse.records
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}