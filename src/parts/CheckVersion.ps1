<#
    .Synopsis
        Validates Version of Secret Server
    .Description
        Validates version of Secret Server
        Throws a message if detected version is lower than input (minimum)
#>
[cmdletbinding()]
param(
    [Parameter(Mandatory,Position = 0)]
    [TssSession]
    $TssSession,

    [Parameter(Mandatory,Position = 1)]
    $MinimumSupported,

    [Parameter(Mandatory,Position = 2)]
    [System.Management.Automation.InvocationInfo]
    $Invocation
)

process {
    $source = $Invocation.MyCommand
    $currentVersion = (Get-TssVersion -TssSession $TssSession).Version

    if ($MinimumSupported -ge $currentVersion) {
        throw "[$source] is only supported on [$MinimumSupported]+ of Secret Server. Secret Server host [$($TssSession.SecretServer)] version: [$currentVersion]"
    }
}