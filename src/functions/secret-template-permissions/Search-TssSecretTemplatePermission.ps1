function Search-TssSecretTemplatePermission {
    <#
    .SYNOPSIS
    Search secret template permissions

    .DESCRIPTION
    Returns the users and groups that hold a role on secret templates, one record per template and user or group.
    Filter by template, group, domain or search text.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DomainId
    Return only permissions held by groups of this domain ID

    .PARAMETER GroupId
    Return only permissions held by this group ID

    .PARAMETER SearchText
    Text to search for

    .PARAMETER SecretTemplateId
    Return only permissions on this secret template ID

    .PARAMETER UserSearchText
    Text to search for in user and group names

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplatePermission -TssSession $session -SecretTemplateId 6001

    Get the users and groups that hold a role on template 6001

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Search-TssSecretTemplatePermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Search-TssSecretTemplatePermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplatePermissions.Permission[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DomainId,

        [int]
        $GroupId,

        [string]
        $SearchText,

        [Alias('SecretTypeId')]
        [int]
        $SecretTemplateId,

        [string]
        $UserSearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-template-permissions' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DomainId' {
                    $queryParams += "filter.domainId=$($DomainId)"
                }
                'GroupId' {
                    $queryParams += "filter.groupId=$($GroupId)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'SecretTemplateId' {
                    $queryParams += "filter.secretTypeId=$($SecretTemplateId)"
                }
                'UserSearchText' {
                    $queryParams += "filter.userSearchText=$([uri]::EscapeDataString($UserSearchText))"
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
                Write-Warning 'Issue with Search-TssSecretTemplatePermission request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SecretTemplatePermissions.Permission[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SecretTemplatePermissions.Permission]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
