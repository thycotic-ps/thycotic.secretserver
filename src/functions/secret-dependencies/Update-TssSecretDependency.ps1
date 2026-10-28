function Update-TssSecretDependency {
    <#
    .SYNOPSIS
    Update a secret dependency

    .DESCRIPTION
    Update a secret dependency by sending the whole dependency object back to Secret Server.
    Read the dependency with Get-TssSecretDependency, change its properties (for example Active, Description, Settings, or the field values in DependencyTemplate.DependencyScanItemFields) and pass it to this command.
    Every property of the object is saved, so start from a current Get-TssSecretDependency result.
    A SshKeySecretId, PrivilegedAccountSecretId or ConditionDependencyId of 0 means none and is sent as null (the server rejects 0 as a secret ID).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Dependency
    Secret dependency object, as returned by Get-TssSecretDependency

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $dependency = Get-TssSecretDependency -TssSession $session -Id 15
    $dependency.Active = $false
    Update-TssSecretDependency -TssSession $session -Dependency $dependency

    Disable secret dependency 15

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $dependency = Get-TssSecretDependency -TssSession $session -Id 15
    ($dependency.DependencyTemplate.DependencyScanItemFields | Where-Object Name -EQ 'Machine').Value = 'app02.corp.example.com'
    $dependency | Update-TssSecretDependency -TssSession $session

    Point template-based secret dependency 15 at another machine (its Machine field wins over RunScript.MachineName)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Update-TssSecretDependency

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Update-TssSecretDependency.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Dependency')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipeline)]
        [Thycotic.PowerShell.SecretDependencies.Dependency[]]
        $Dependency
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentDependency in $Dependency) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-dependencies', $currentDependency.Id -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'
                $dependencyBody = $currentDependency | ConvertTo-Json -Depth 100 | ConvertFrom-Json
                foreach ($optionalId in 'SshKeySecretId', 'PrivilegedAccountSecretId', 'ConditionDependencyId') {
                    if ($dependencyBody.$optionalId -eq 0) {
                        $dependencyBody.$optionalId = $null
                    }
                }
                $invokeParams.Body = $dependencyBody | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Secret dependency: $($currentDependency.Id)", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Update-TssSecretDependency request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.SecretDependencies.Dependency](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretDependencies.Dependency]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
