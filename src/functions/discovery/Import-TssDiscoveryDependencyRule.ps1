function Import-TssDiscoveryDependencyRule {
    <#
    .SYNOPSIS
    Import discovered dependencies

    .DESCRIPTION
    Starts a bulk operation that creates secret dependencies for the discovered dependencies passed in ItemId, the same import Discovery dependency rules run. Returns the bulk operation id.
    When the account of a dependency has no active linked secret the import creates one, and the server then needs SecretTypeId, FolderId, SecretNameFormat and SiteId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ChangePassword
    Change the account password on import

    .PARAMETER DependencyPrivilegedAccountId
    Secret id of the privileged account the dependencies run with

    .PARAMETER FolderId
    Folder where created secrets go, required when a secret is created

    .PARAMETER ItemId
    Discovered dependency ids to import

    .PARAMETER NextPassword
    New password to set when changing it without RandomPassword

    .PARAMETER Password
    Current account password to store in created secrets

    .PARAMETER RandomPassword
    Generate a random password when changing it

    .PARAMETER RestartService
    Restart the service after a password change

    .PARAMETER SecretDependencyTemplateId
    Secret dependency template id for created dependencies

    .PARAMETER SecretNameFormat
    Pattern used to name created secrets: $ followed by a secret template field name is replaced by that field value, for example $DOMAIN\$USERNAME.
    Required when a secret is created: the server fails each such item without it.

    .PARAMETER SecretPrivilegedAccount
    Secret id of the privileged account used to change passwords

    .PARAMETER SecretTypeId
    Secret template id used when a secret is created for the dependency account, required when a secret is created

    .PARAMETER SiteId
    Site used for created secrets, required when a secret is created

    .PARAMETER SshKeySecretId
    Secret id of the SSH key used for the dependency

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssDiscoveryDependencyRule -TssSession $session -ItemId 77 -SecretDependencyTemplateId 3 -DependencyPrivilegedAccountId 15 -SecretTypeId 6001 -FolderId 12 -SecretNameFormat '$DOMAIN\$USERNAME' -SiteId 1

    Create a secret dependency for discovered dependency 77, with any secret it needs created in folder 12 on site 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Import-TssDiscoveryDependencyRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Import-TssDiscoveryDependencyRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.BulkOperation')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $ChangePassword,

        [int]
        $DependencyPrivilegedAccountId,

        [int]
        $FolderId,

        [Parameter(Mandatory)]
        [int[]]
        $ItemId,

        [securestring]
        $NextPassword,

        [securestring]
        $Password,

        [switch]
        $RandomPassword,

        [switch]
        $RestartService,

        [int]
        $SecretDependencyTemplateId,

        [string]
        $SecretNameFormat,

        [int]
        $SecretPrivilegedAccount,

        [int]
        $SecretTypeId,

        [int]
        $SiteId,

        [int]
        $SshKeySecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'dependencies', 'import' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ChangePassword' {
                    $body.data.Add('changePassword', [boolean]$ChangePassword)
                }
                'DependencyPrivilegedAccountId' {
                    $body.data.Add('dependencyPrivilegedAccountId', $DependencyPrivilegedAccountId)
                }
                'FolderId' {
                    $body.data.Add('folderId', $FolderId)
                }
                'ItemId' {
                    $body.data.Add('itemIds', $ItemId)
                }
                'NextPassword' {
                    $body.data.Add('nextPassword', [System.Net.NetworkCredential]::new('', $NextPassword).Password)
                }
                'Password' {
                    $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
                'RandomPassword' {
                    $body.data.Add('randomPassword', [boolean]$RandomPassword)
                }
                'RestartService' {
                    $body.data.Add('restartService', [boolean]$RestartService)
                }
                'SecretDependencyTemplateId' {
                    $body.data.Add('secretDependencyTemplateId', $SecretDependencyTemplateId)
                }
                'SecretNameFormat' {
                    $body.data.Add('secretNameFormat', $SecretNameFormat)
                }
                'SecretPrivilegedAccount' {
                    $body.data.Add('secretPrivilegedAccount', $SecretPrivilegedAccount)
                }
                'SecretTypeId' {
                    $body.data.Add('secretTypeId', $SecretTypeId)
                }
                'SiteId' {
                    $body.data.Add('siteId', $SiteId)
                }
                'SshKeySecretId' {
                    $body.data.Add('sshKeySecretId', $SshKeySecretId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery dependency rule", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssDiscoveryDependencyRule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.BulkOperation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.BulkOperation]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
