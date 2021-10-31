function Find-TssSecret {
    <#
    .SYNOPSIS
    Find a secret

    .DESCRIPTION
    Find secrets using various filters provided by each parameter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -FolderId 50 -RpcEnabled

    Return secrets found in folder 50 where RPC is enabled on the secret templates

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -FolderId 50 -SecretTemplateId 6001

    Return all secrets using Secret Template 6001 that are found in FolderID 50.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -SecretTemplateId 6047 -IncludeInactive

    Return all secrets using Secret Template 6047 that are active **and** inactive.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -SecretName 'Azure'

    Return all secrets that have Azure in the name of the Secret (wildcard search)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -SecretName 'Azure Test Account' -ExactMatch

    Return all secret(s) that have the exact name "Azure Test Account"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -Field username -SearchText 'root'

    Return all secret(s) that contain "root" in the username field value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -FolderId 85

    Return all secret(s) contained in Folder ID 85

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssSecret -TssSession $session -FolderId 85 -IncludeSubFolders

    Return all secret(s) contained in Folder ID 85 and any child folders.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Find-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Find-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = 'filter')]
    [OutputType('Thycotic.PowerShell.Secrets.Lookup')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID to retrieve
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'secret')]
        [Alias('SecretId')]
        [int]
        $Id,

        # Returns only secrets within the specified folder.
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'folder')]
        [int]
        $FolderId,

        # Whether to include secrets in subfolders of the specified folder.
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

        # Whether to do an exact match of the search text or a partial match. If an exact match, the entire secret name, field value, or list option in a list field must match the search text.
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

        # An array of names of Secret Template fields to return. Only exposed fields can be returned.
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'field')]
        [Alias('ExtendedFields')]
        [string[]]
        $ExtendedField,

        # If not null, return only secrets matching the specified extended mapping type as defined on the secret’s template.
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
        [Thycotic.PowerShell.Enums.SecretHeartbeatStatus]
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
        [Thycotic.PowerShell.Enums.SecretPermissions]
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

        # Only include Secrets with this DoubleLock ID assigned in the search results.
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
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($tssParams['Id']) {
                $uri = $TssSession.ApiUrl , 'secrets/lookup', $Id -join '/'
            } else {
                $uri = $TssSession.ApiUrl, 'secrets/lookup' -join '/'
                $uri += "?sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)"
                $uri += '&filter.includeRestricted=true'

                $filters = @()
                switch ($tssParams.Keys) {
                    'TssSession' { <# do nothing, added for performance #> }
                    'Id' { <# do nothing, added for performance #> }
                    'SiteId' { $filters += "filter.siteId=$SiteId" }
                    'FolderId' { $filters += "filter.folderId=$FolderId" }
                    'IncludeSubFolders' { $filters += "filter.includeSubFolders=$([boolean]$IncludeSubFolders))" }
                    'Field' { $filters += "filter.searchField=$($Field)" }
                    'FieldSlug' { $filters += "filter.searchFieldSlug=$FieldSlug" }
                    'SearchText' { $filters += "filter.searchText=$SearchText" }
                    'SecretTemplateId' { $filters += "filter.secretTemplateId=$SecretTemplateId" }
                    'HeartbeatStatus' { $filters += "filter.heartbeatStatus=$([string]$HeartbeatStatus)" }
                    'ExactMatch' { $filters += "filter.isExactmatch=$([boolean]$ExactMatch)" }
                    'Permission' { $filters += "filter.permissionRequired=$Permission" }
                    'RpcEnabled' { $filters += "filter.onlyRPCEnabled=$([boolean]$RpcEnabled)" }
                    'SharedWithMe' { $filters += "filter.onlySharedWithMe=$([boolean]$SharedWithMe)" }
                    'ExcludeDoubleLock' { $filters += "filter.allowDoubleLocks=$([boolean]$ExcludeDoubleLock)" }
                    'ExcludeActive' { $filters += "filter.includeActive=$([boolean]$ExcludeActive)" }
                    'Scope' {
                        $filters += switch ($tssParams['Scope']) {
                            'All' { 'filter.scope=1' }
                            'Recent' { 'filter.scope=2' }
                            'Favorite' { 'filter.scope=3' }
                        }
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
                }
                if ($filters) {
                    $uriFilter = $filters -join '&'
                    Write-Verbose "Filters: $uriFilter"
                    $uri = $uri, $uriFilter -join '&'
                }
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

            if ($tssParams.ContainsKey('Id') -and $restResponse) {
                [Thycotic.PowerShell.Secrets.Lookup]@{
                    Id         = $restResponse.Id
                    SecretName = $restResponse.value
                }
            } else {
                if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                    Write-Warning 'No secrets found'
                }
                if ($restResponse) {
                    foreach ($secret in $restResponse.records) {
                        $parsedValue = $secret.value.Split('-', 3).Trim()
                        [Thycotic.PowerShell.Secrets.Lookup]@{
                            Id               = $secret.id
                            FolderId         = $parsedValue[0]
                            SecretTemplateId = $parsedValue[1]
                            SecretName       = $parsedValue[2]
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}