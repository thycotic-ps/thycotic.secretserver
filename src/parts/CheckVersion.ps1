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
    [Thycotic.PowerShell.Authentication.Session]
    $TssSession,

    [Parameter(Mandatory,Position = 1)]
    $MinimumSupported,

    [Parameter(Mandatory,Position = 2)]
    [System.Management.Automation.InvocationInfo]
    $Invocation
)
begin {
    $invokeParams = . $GetInvokeTssParams $TssSession
}
process {
    $source = $Invocation.MyCommand
    $currentVersion = $TssSession.SecretServerVersion

    if ($currentVersion -lt $MinimumSupported) {
        Write-Verbose "[$source] is only supported on [$MinimumSupported]+ of Secret Server. Secret Server host [$($TssSession.SecretServer)] version: [$currentVersion]"
    }
}