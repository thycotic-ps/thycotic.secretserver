function New-TssDiscoveryAccountRule {
    <#
    .SYNOPSIS
    Create a Discovery account rule

    .DESCRIPTION
    Creates a Discovery account rule that matches discovered accounts of one discovery source by scan template, organizational unit and name filters, and optionally creates secrets for them. Returns the created rule.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

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
    Discovery source the rule applies to

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
    New-TssDiscoveryAccountRule -TssSession $session -RuleName 'Local admins' -RuleDescription 'Local admin accounts' -DiscoverySourceId 1 -ScanTemplateId 1 -AccountNameContains admin -IsActive

    Create an active rule that matches local accounts whose name contains admin

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoveryAccountRule -TssSession $session -RuleName 'Import service accounts' -RuleDescription 'Imports service accounts' -DiscoverySourceId 1 -ScanTemplateId 1 -ActionCreateSecrets -SecretTemplateId 6003 -FolderId 12 -SiteId 1 -PasswordOption Current -SecretPermissions InheritPermission

    Create a rule that imports matched accounts of discovery source 1 into folder 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryAccountRule

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryAccountRule.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.AccountRule')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

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

        [Parameter(Mandatory)]
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

        [Parameter(Mandatory)]
        [string]
        $RuleDescription,

        [Parameter(Mandatory)]
        [string]
        $RuleName,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'rules', 'accounts' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AccountAlerts' {
                    $body.data.Add('accountAlerts', [boolean]$AccountAlerts)
                }
                'AccountNameContains' {
                    $body.data.Add('accountNameContains', $AccountNameContains)
                }
                'ActionCreateSecrets' {
                    $body.data.Add('actionCreateSecrets', [boolean]$ActionCreateSecrets)
                }
                'ComputerNameContains' {
                    $body.data.Add('computerNameContains', $ComputerNameContains)
                }
                'CurrentPassphrase' {
                    $body.data.Add('currentPassphrase', [System.Net.NetworkCredential]::new('', $CurrentPassphrase).Password)
                }
                'CurrentPassword' {
                    $body.data.Add('currentPassword', [System.Net.NetworkCredential]::new('', $CurrentPassword).Password)
                }
                'CurrentPrivateKey' {
                    $body.data.Add('currentPrivateKey', [System.Net.NetworkCredential]::new('', $CurrentPrivateKey).Password)
                }
                'DiscoverySourceId' {
                    $body.data.Add('discoverySourceId', $DiscoverySourceId)
                }
                'FilterFields' {
                    $body.data.Add('filterFields', $FilterFields)
                }
                'FolderId' {
                    $body.data.Add('folderId', $FolderId)
                }
                'ImportOnlyPolledLastScan' {
                    $body.data.Add('importOnlyPolledLastScan', [boolean]$ImportOnlyPolledLastScan)
                }
                'IncludeChildOUs' {
                    $body.data.Add('includeChildOUs', [boolean]$IncludeChildOUs)
                }
                'IsActive' {
                    $body.data.Add('isActive', [boolean]$IsActive)
                }
                'MatchingCondition' {
                    $body.data.Add('matchingCondition', $MatchingCondition)
                }
                'NewPassword' {
                    $body.data.Add('newPassword', [System.Net.NetworkCredential]::new('', $NewPassword).Password)
                }
                'OperatingSystemContains' {
                    $body.data.Add('operatingSystemContains', $OperatingSystemContains)
                }
                'OrganizationUnitId' {
                    $body.data.Add('organizationUnitId', $OrganizationUnitId)
                }
                'PasswordChangingPrivilegedAccountSecretId' {
                    $body.data.Add('passwordChangingPrivilegedAccountSecretIds', $PasswordChangingPrivilegedAccountSecretId)
                }
                'PasswordChangingType' {
                    $body.data.Add('passwordChangingType', $PasswordChangingType)
                }
                'PasswordOption' {
                    $body.data.Add('passwordOption', $PasswordOption)
                }
                'RuleDescription' {
                    $body.data.Add('ruleDescription', $RuleDescription)
                }
                'RuleName' {
                    $body.data.Add('ruleName', $RuleName)
                }
                'ScanTemplateId' {
                    $body.data.Add('scanTemplateId', $ScanTemplateId)
                }
                'SecretNamePattern' {
                    $body.data.Add('secretNamePattern', $SecretNamePattern)
                }
                'SecretPermissions' {
                    $body.data.Add('secretPermissions', $SecretPermissions)
                }
                'SecretTemplateId' {
                    $body.data.Add('secretTemplateId', $SecretTemplateId)
                }
                'SiteId' {
                    $body.data.Add('siteId', $SiteId)
                }
                'SubscribedSpecificGroupId' {
                    $body.data.Add('subscribedSpecificGroupIds', $SubscribedSpecificGroupId)
                }
                'SubscriberType' {
                    $body.data.Add('subscriberType', $SubscriberType)
                }
                'TakeOverAccountType' {
                    $body.data.Add('takeOverAccountType', $TakeOverAccountType)
                }
                'TakeOverPasswordTypeId' {
                    $body.data.Add('takeOverPasswordTypeId', $TakeOverPasswordTypeId)
                }
                'TakeoverSecretId' {
                    $body.data.Add('takeoverSecretIds', $TakeoverSecretId)
                }
                'TakeOverThreshold' {
                    $body.data.Add('takeOverThreshold', $TakeOverThreshold)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery account rule", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoveryAccountRule request'
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
