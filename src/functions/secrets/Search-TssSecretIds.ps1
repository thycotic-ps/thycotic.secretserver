function Search-TssSecretIds {
    <#
    .SYNOPSIS
    Get the IDs of secrets matching a search filter

    .DESCRIPTION
    Returns the ID of every secret the current user can see that matches the filter. Lighter than Search-TssSecret when only IDs are needed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SearchText
    Text to match against secret names and field values

    .PARAMETER FolderId
    Only secrets in this folder

    .PARAMETER IncludeSubFolders
    Include secrets in subfolders of FolderId

    .PARAMETER Field
    Field name to search with SearchText

    .PARAMETER FieldSlug
    Field slug to search with SearchText

    .PARAMETER ExactMatch
    Match SearchText exactly

    .PARAMETER SecretTemplateId
    Only secrets of these secret templates

    .PARAMETER SiteId
    Only secrets assigned to this site

    .PARAMETER HeartbeatStatus
    Only secrets with this heartbeat status

    .PARAMETER IncludeInactive
    Include inactive secrets

    .PARAMETER IncludeRestricted
    Include restricted secrets (checkout, approval, comment or double lock required)

    .PARAMETER RpcEnabled
    Only secrets whose template has password changing enabled

    .PARAMETER SharedWithMe
    Only secrets explicitly shared with the current user

    .PARAMETER PasswordTypeIds
    Only secrets with these password types

    .PARAMETER DoubleLockId
    Only secrets with this double lock

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretIds -TssSession $session -FolderId 12 -IncludeSubFolders

    Returns the IDs of the secrets in folder 12 and its subfolders

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretIds -TssSession $session -SearchText 'sql' | ForEach-Object { Get-TssSecret -TssSession $session -Id $_ }

    Gets each secret whose name or fields match sql

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretIds

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretIds.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Int32[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SearchText,

        [int]
        $FolderId,

        [switch]
        $IncludeSubFolders,

        [string]
        $Field,

        [string]
        $FieldSlug,

        [switch]
        $ExactMatch,

        [int[]]
        $SecretTemplateId,

        [int]
        $SiteId,

        [Thycotic.PowerShell.Enums.SecretHeartbeatStatus]
        $HeartbeatStatus,

        [switch]
        $IncludeInactive,

        [switch]
        $IncludeRestricted,

        [switch]
        $RpcEnabled,

        [switch]
        $SharedWithMe,

        [int[]]
        $PasswordTypeIds,

        [int]
        $DoubleLockId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', 'search-for-ids' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'FolderId' {
                    $queryParams += "filter.folderId=$($FolderId)"
                }
                'IncludeSubFolders' {
                    $queryParams += "filter.includeSubFolders=$([boolean]$IncludeSubFolders)"
                }
                'Field' {
                    $queryParams += "filter.searchField=$([uri]::EscapeDataString($Field))"
                }
                'FieldSlug' {
                    $queryParams += "filter.searchFieldSlug=$([uri]::EscapeDataString($FieldSlug))"
                }
                'ExactMatch' {
                    $queryParams += "filter.isExactMatch=$([boolean]$ExactMatch)"
                }
                'SecretTemplateId' {
                    foreach ($queryValue in $SecretTemplateId) {
                        $queryParams += "filter.secretTemplateIds=$($queryValue)"
                    }
                }
                'SiteId' {
                    $queryParams += "filter.siteId=$($SiteId)"
                }
                'HeartbeatStatus' {
                    $queryParams += "filter.heartbeatStatus=$($HeartbeatStatus)"
                }
                'IncludeInactive' {
                    $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                }
                'IncludeRestricted' {
                    $queryParams += "filter.includeRestricted=$([boolean]$IncludeRestricted)"
                }
                'RpcEnabled' {
                    $queryParams += "filter.onlyRPCEnabled=$([boolean]$RpcEnabled)"
                }
                'SharedWithMe' {
                    $queryParams += "filter.onlySharedWithMe=$([boolean]$SharedWithMe)"
                }
                'PasswordTypeIds' {
                    foreach ($queryValue in $PasswordTypeIds) {
                        $queryParams += "filter.passwordTypeIds=$($queryValue)"
                    }
                }
                'DoubleLockId' {
                    $queryParams += "filter.doubleLockId=$($DoubleLockId)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretIds request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse) {
                [int[]]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
