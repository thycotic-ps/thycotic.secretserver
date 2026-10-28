function Set-TssDiscoveryAccountRule {
    <#
    .SYNOPSIS
    Update a Discovery account rule

    .DESCRIPTION
    Updates only the fields passed; omitted fields stay unchanged. Returns the updated rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery account rule id

    .PARAMETER AccountAlerts
    Send an alert to the subscribers when the rule matches new accounts

    .PARAMETER AccountNameContains
    Only match accounts whose name contains this text

    .PARAMETER ActionCreateSecrets
    Create secrets for matched accounts. Requires PasswordOption, SecretPermissions and SiteId

    .PARAMETER ComputerNameContains
    Only match computers whose name contains this text

    .PARAMETER CurrentPassphrase
    Passphrase of the current private key, when PasswordOption is PrivateKey

    .PARAMETER CurrentPassword
    Current password to store in created secrets, when PasswordOption is Current

    .PARAMETER CurrentPrivateKey
    Current private key to store in created secrets, when PasswordOption is PrivateKey

    .PARAMETER DiscoverySourceId
    Limit the rule to one discovery source

    .PARAMETER FilterFields
    Dynamic filters for the scan template: objects or hashtables with scanItemFieldId (int) and filterFieldValue (string)

    .PARAMETER FolderId
    Folder where created secrets go

    .PARAMETER ImportOnlyPolledLastScan
    Only import accounts found by the last scan

    .PARAMETER IncludeChildOUs
    Include child organizational units of OrganizationUnitId

    .PARAMETER IsActive
    Make the rule active

    .PARAMETER MatchingCondition
    How ComputerNameContains and AccountNameContains combine: And or Or

    .PARAMETER NewPassword
    New password to set, when PasswordOption is ChangeTo

    .PARAMETER OperatingSystemContains
    Only match computers whose operating system contains this text

    .PARAMETER OrganizationUnitId
    Limit the rule to one organizational unit

    .PARAMETER PasswordChangingPrivilegedAccountSecretId
    Secret ids of the privileged accounts used to change passwords, when PasswordChangingType is PrivilegedAccount

    .PARAMETER PasswordChangingType
    Credentials used to change passwords: SecretCredentials or PrivilegedAccount

    .PARAMETER PasswordOption
    What password created secrets get: Current, ChangeTo, Random, PrivateKey or PublicKey

    .PARAMETER RuleDescription
    Rule description

    .PARAMETER RuleName
    Rule name

    .PARAMETER ScanTemplateId
    Scan template the rule applies to

    .PARAMETER SecretNamePattern
    Pattern used to name created secrets

    .PARAMETER SecretPermissions
    How created secrets get permissions: InheritPermission or CopyPermission

    .PARAMETER SecretTemplateId
    Secret template used for created secrets

    .PARAMETER SiteId
    Site used for created secrets

    .PARAMETER SubscribedSpecificGroupId
    Group ids that receive alerts, when SubscriberType is SpecificUsers

    .PARAMETER SubscriberType
    Who receives alerts: Admins or SpecificUsers

    .PARAMETER TakeOverAccountType
    Takeover account mode: Single or Multiple

    .PARAMETER TakeOverPasswordTypeId
    Password type id used for takeover

    .PARAMETER TakeoverSecretId
    Secret ids of the accounts used for takeover

    .PARAMETER TakeOverThreshold
    Takeover threshold

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryAccountRule -TssSession $session -Id 3 -RuleDescription 'Matches local admin accounts'

    Change the description of Discovery account rule 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryAccountRule -TssSession $session -Id 3 -IsActive:$false

    Deactivate Discovery account rule 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryAccountRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryAccountRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.AccountRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RuleId')]
        [int]
        $Id,

        [switch]
        $AccountAlerts,

        [string]
        $AccountNameContains,

        [switch]
        $ActionCreateSecrets,

        [string]
        $ComputerNameContains,

        [securestring]
        $CurrentPassphrase,

        [securestring]
        $CurrentPassword,

        [securestring]
        $CurrentPrivateKey,

        [int]
        $DiscoverySourceId,

        [object[]]
        $FilterFields,

        [int]
        $FolderId,

        [switch]
        $ImportOnlyPolledLastScan,

        [switch]
        $IncludeChildOUs,

        [switch]
        $IsActive,

        [ValidateSet('And', 'Or')]
        [string]
        $MatchingCondition,

        [securestring]
        $NewPassword,

        [string]
        $OperatingSystemContains,

        [int]
        $OrganizationUnitId,

        [int[]]
        $PasswordChangingPrivilegedAccountSecretId,

        [ValidateSet('PrivilegedAccount', 'SecretCredentials')]
        [string]
        $PasswordChangingType,

        [ValidateSet('Current', 'ChangeTo', 'Random', 'PrivateKey', 'PublicKey')]
        [string]
        $PasswordOption,

        [string]
        $RuleDescription,

        [string]
        $RuleName,

        [int]
        $ScanTemplateId,

        [string]
        $SecretNamePattern,

        [ValidateSet('InheritPermission', 'CopyPermission')]
        [string]
        $SecretPermissions,

        [int]
        $SecretTemplateId,

        [int]
        $SiteId,

        [int[]]
        $SubscribedSpecificGroupId,

        [ValidateSet('Admins', 'SpecificUsers')]
        [string]
        $SubscriberType,

        [ValidateSet('Single', 'Multiple')]
        [string]
        $TakeOverAccountType,

        [int]
        $TakeOverPasswordTypeId,

        [int[]]
        $TakeoverSecretId,

        [int]
        $TakeOverThreshold
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'accounts', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AccountAlerts' {
                    $body.data.Add('accountAlerts', @{ dirty = $true; value = [boolean]$AccountAlerts })
                }
                'AccountNameContains' {
                    $body.data.Add('accountNameContains', @{ dirty = $true; value = $AccountNameContains })
                }
                'ActionCreateSecrets' {
                    $body.data.Add('actionCreateSecrets', @{ dirty = $true; value = [boolean]$ActionCreateSecrets })
                }
                'ComputerNameContains' {
                    $body.data.Add('computerNameContains', @{ dirty = $true; value = $ComputerNameContains })
                }
                'CurrentPassphrase' {
                    $body.data.Add('currentPassphrase', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $CurrentPassphrase).Password })
                }
                'CurrentPassword' {
                    $body.data.Add('currentPassword', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $CurrentPassword).Password })
                }
                'CurrentPrivateKey' {
                    $body.data.Add('currentPrivateKey', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $CurrentPrivateKey).Password })
                }
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceId', @{ dirty = $true; value = $DiscoverySourceId })
                }
                'FilterFields' {
                    $body.data.Add('filterFields', @{ dirty = $true; value = $FilterFields })
                }
                'FolderId' {
                    $body.data.Add('folderId', @{ dirty = $true; value = $FolderId })
                }
                'ImportOnlyPolledLastScan' {
                    $body.data.Add('importOnlyPolledLastScan', @{ dirty = $true; value = [boolean]$ImportOnlyPolledLastScan })
                }
                'IncludeChildOUs' {
                    $body.data.Add('includeChildOUs', @{ dirty = $true; value = [boolean]$IncludeChildOUs })
                }
                'IsActive' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$IsActive })
                }
                'MatchingCondition' {
                    $body.data.Add('matchingCondition', @{ dirty = $true; value = $MatchingCondition })
                }
                'NewPassword' {
                    $body.data.Add('newPassword', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $NewPassword).Password })
                }
                'OperatingSystemContains' {
                    $body.data.Add('operatingSystemContains', @{ dirty = $true; value = $OperatingSystemContains })
                }
                'OrganizationUnitId' {
                    $body.data.Add('organizationUnitId', @{ dirty = $true; value = $OrganizationUnitId })
                }
                'PasswordChangingPrivilegedAccountSecretId' {
                    $body.data.Add('passwordChangingPrivilegedAccountSecretIds', @{ dirty = $true; value = $PasswordChangingPrivilegedAccountSecretId })
                }
                'PasswordChangingType' {
                    $body.data.Add('passwordChangingType', @{ dirty = $true; value = $PasswordChangingType })
                }
                'PasswordOption' {
                    $body.data.Add('passwordOption', @{ dirty = $true; value = $PasswordOption })
                }
                'RuleDescription' {
                    $body.data.Add('ruleDescription', @{ dirty = $true; value = $RuleDescription })
                }
                'RuleName' {
                    $body.data.Add('ruleName', @{ dirty = $true; value = $RuleName })
                }
                'ScanTemplateId' {
                    $body.data.Add('scanTemplateId', @{ dirty = $true; value = $ScanTemplateId })
                }
                'SecretNamePattern' {
                    $body.data.Add('secretNamePattern', @{ dirty = $true; value = $SecretNamePattern })
                }
                'SecretPermissions' {
                    $body.data.Add('secretPermissions', @{ dirty = $true; value = $SecretPermissions })
                }
                'SecretTemplateId' {
                    $body.data.Add('secretTemplateId', @{ dirty = $true; value = $SecretTemplateId })
                }
                'SiteId' {
                    $body.data.Add('siteId', @{ dirty = $true; value = $SiteId })
                }
                'SubscribedSpecificGroupId' {
                    $body.data.Add('subscribedSpecificGroupIds', @{ dirty = $true; value = $SubscribedSpecificGroupId })
                }
                'SubscriberType' {
                    $body.data.Add('subscriberType', @{ dirty = $true; value = $SubscriberType })
                }
                'TakeOverAccountType' {
                    $body.data.Add('takeOverAccountType', @{ dirty = $true; value = $TakeOverAccountType })
                }
                'TakeOverPasswordTypeId' {
                    $body.data.Add('takeOverPasswordTypeId', @{ dirty = $true; value = $TakeOverPasswordTypeId })
                }
                'TakeoverSecretId' {
                    $body.data.Add('takeoverSecretIds', @{ dirty = $true; value = $TakeoverSecretId })
                }
                'TakeOverThreshold' {
                    $body.data.Add('takeOverThreshold', @{ dirty = $true; value = $TakeOverThreshold })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery account rule: $Id", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryAccountRule request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.AccountRule](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.AccountRule]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
