if (Test-Path "$env:USERPROFILE\constants.ps1") {
    if (-not $IsLinux) {
        . "$env:USERPROFILE\constants.ps1"
    } else {
        . "$env:HOME/constants.ps1"
    }
} else {
    $script:ss = 'http://alpha'
    # $script:ss = 'https://tenant.secretservercloud.com'

    $script:ssCred = $secretalphaCred
    # $script:ssCred = $secretCloudCred

    $tssTestUsingWindowsAuth = $false
}
