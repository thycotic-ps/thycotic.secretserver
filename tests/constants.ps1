if (Test-Path "$env:USERPROFILE\constants.ps1") {
    if (-not $IsLinux) {
        . "$env:USERPROFILE\constants.ps1"
    } else {
        . "$env:HOME/constants.ps1"
    }
} else {
    $script:ss = 'http://vault3'
    # $script:ss = 'https://tenant.secretservercloud.com'

    $script:ssCred = $secretVault3Cred
    # $script:ssCred = $secretCloudCred
}
