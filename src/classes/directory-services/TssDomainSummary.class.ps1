class TssDomainSummary {
    [boolean]
    $Active

    [int]
    $DomainId

    [string]
    $DomainName

    [ValidateSet('ActiveDirectory','OpenLdap','AzureActiveDirectory')]
    [string]
    $DomainType

    [string]
    $FriendlyName

    [boolean]
    $RequireRadiusAuthentication

    [boolean]
    $UseSecureLdap
}