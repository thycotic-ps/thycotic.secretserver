function Import-TssDiscoveryAccountRule {
    <#
    .SYNOPSIS
    Import discovered accounts as secrets

    .DESCRIPTION
    Starts a bulk operation that creates secrets for the discovered accounts passed in ItemId, the same import Discovery account rules run. Returns the bulk operation id.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ChangePassword
    Change the account password on import

    .PARAMETER DiscoverySourceId
    Discovery source of the accounts

    .PARAMETER FolderId
    Folder where created secrets go

    .PARAMETER ItemId
    Discovered computer account ids to import

    .PARAMETER NextPassword
    New password to set when changing it without RandomPassword

    .PARAMETER Passphrase
    Passphrase of the private key

    .PARAMETER Password
    Current account password to store in created secrets

    .PARAMETER PrivateKey
    Current private key to store in created secrets

    .PARAMETER RandomPassword
    Generate a random password when changing it

    .PARAMETER ScanItemTemplateId
    Scan template of the accounts

    .PARAMETER SecretNameFormat
    Pattern used to name created secrets: $ followed by a secret template field name is replaced by that field value, for example $MACHINE\$USERNAME.
    Required because the server fails every item of an import without it.

    .PARAMETER SecretPrivilegedAccount
    Secret ids of privileged accounts used to change passwords, empty when not given

    .PARAMETER SecretTypeId
    Secret template id used for created secrets

    .PARAMETER SiteId
    Site used for created secrets.
    Required because the server fails every item of an import without it.

    .PARAMETER TakeOverAccountPasswordTypeId
    Password type id used for takeover

    .PARAMETER TakeOverAccountSecrets
    Secret ids of accounts used for takeover, empty when not given

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssDiscoveryAccountRule -TssSession $session -ItemId 118, 119 -DiscoverySourceId 2 -ScanItemTemplateId 1 -SecretTypeId 6007 -FolderId 12 -SecretNameFormat '$MACHINE\$USERNAME' -SiteId 1

    Create secrets named after the machine and account in folder 12, on site 1, for discovered accounts 118 and 119

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Import-TssDiscoveryAccountRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Import-TssDiscoveryAccountRule.ps1

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

        [Parameter(Mandatory)]
        [int]
        $DiscoverySourceId,

        [int]
        $FolderId,

        [Parameter(Mandatory)]
        [int[]]
        $ItemId,

        [securestring]
        $NextPassword,

        [securestring]
        $Passphrase,

        [securestring]
        $Password,

        [securestring]
        $PrivateKey,

        [switch]
        $RandomPassword,

        [Parameter(Mandatory)]
        [int]
        $ScanItemTemplateId,

        [Parameter(Mandatory)]
        [string]
        $SecretNameFormat,

        [int[]]
        $SecretPrivilegedAccount,

        [Parameter(Mandatory)]
        [int]
        $SecretTypeId,

        [Parameter(Mandatory)]
        [int]
        $SiteId,

        [int]
        $TakeOverAccountPasswordTypeId,

        [int[]]
        $TakeOverAccountSecrets
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'account', 'import' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ secretPrivilegedAccount = @(); takeOverAccountSecrets = @() } }
            switch ($tssParams.Keys) {
                'ChangePassword' {
                    $body.data.Add('changePassword', [boolean]$ChangePassword)
                }
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceId', $DiscoverySourceId)
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
                'Passphrase' {
                    $body.data.Add('passphrase', [System.Net.NetworkCredential]::new('', $Passphrase).Password)
                }
                'Password' {
                    $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
                'PrivateKey' {
                    $body.data.Add('privateKey', [System.Net.NetworkCredential]::new('', $PrivateKey).Password)
                }
                'RandomPassword' {
                    $body.data.Add('randomPassword', [boolean]$RandomPassword)
                }
                'ScanItemTemplateId' {
                    $body.data.Add('scanItemTemplateId', $ScanItemTemplateId)
                }
                'SecretNameFormat' {
                    $body.data.Add('secretNameFormat', $SecretNameFormat)
                }
                'SecretPrivilegedAccount' {
                    $body.data.secretPrivilegedAccount = $SecretPrivilegedAccount
                }
                'SecretTypeId' {
                    $body.data.Add('secretTypeId', $SecretTypeId)
                }
                'SiteId' {
                    $body.data.Add('siteId', $SiteId)
                }
                'TakeOverAccountPasswordTypeId' {
                    $body.data.Add('takeOverAccountPasswordTypeId', $TakeOverAccountPasswordTypeId)
                }
                'TakeOverAccountSecrets' {
                    $body.data.takeOverAccountSecrets = $TakeOverAccountSecrets
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery account rule", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssDiscoveryAccountRule request'
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
