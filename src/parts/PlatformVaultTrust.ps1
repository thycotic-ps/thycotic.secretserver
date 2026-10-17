[cmdletbinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [AllowNull()]
    [AllowEmptyString()]
    [string]
    $VaultUrl,

    [Parameter(Mandatory, Position = 1)]
    [uri]
    $PlatformUrl,

    [Parameter(Position = 2)]
    [AllowNull()]
    [string[]]
    $AllowedVaultHost
)
$cloudVaultDomains = 'secretservercloud.com', 'secretservercloud.eu', 'secretservercloud.com.au', 'secretservercloud.com.sg', 'secretservercloud.ca', 'secretservercloud.co.uk', 'secretservercloud.ae', 'devsecretservercloud.com'

$vault = $null
if (-not [uri]::TryCreate($VaultUrl, [UriKind]::Absolute, [ref]$vault) -or $vault.Scheme -ne 'https') {
    throw "Vault URL [$VaultUrl] was refused: only an absolute https vault URL is trusted."
}
if ($vault.UserInfo -or $vault.Query -or $vault.Fragment) {
    throw "Vault URL [$VaultUrl] was refused: user info, query and fragment are not allowed."
}
$vaultHost = $vault.Host.ToLowerInvariant()
$vaultAuthority = '{0}:{1}' -f $vaultHost, $vault.Port

if ($vault.Authority -eq $PlatformUrl.Authority) {
    return
}
if ($vault.IsDefaultPort -and ($cloudVaultDomains | Where-Object { $vaultHost.EndsWith(".$_") })) {
    return
}
foreach ($allowed in @($AllowedVaultHost | Where-Object { $_ })) {
    $entry = $allowed.Trim().ToLowerInvariant()
    if ($entry -eq $vaultAuthority -or ($vault.IsDefaultPort -and $entry -eq $vaultHost)) {
        return
    }
}
$hint = if ($vault.IsDefaultPort) { $vaultHost } else { $vaultAuthority }
throw "Vault host [$hint] is not trusted: it is not a Secret Server Cloud host or the Platform host. Add -AllowedVaultHost $hint to New-TssSession to trust it."
