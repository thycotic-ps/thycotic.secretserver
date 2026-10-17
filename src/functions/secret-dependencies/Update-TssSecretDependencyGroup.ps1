function Update-TssSecretDependencyGroup {
    <#
    .SYNOPSIS
    Rename a secret dependency group or change its site

    .DESCRIPTION
    Rename a dependency group on a secret, or change the site its dependencies run on.
    The server replaces both the name and the site on every update, so the command first reads the secret's dependency groups (Get-TssSecretDependencyGroup) and keeps the current value of anything you do not pass.
    The group must be one of the secret's dependency groups; otherwise nothing is sent.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the secret the dependency group is on

    .PARAMETER GroupId
    ID of the dependency group (the Id property of Get-TssSecretDependencyGroup output)

    .PARAMETER GroupName
    New name of the dependency group

    .PARAMETER SiteId
    Site the group's dependencies run on; 0 sets Site from Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretDependencyGroup -TssSession $session -Id 1050 -GroupId 12 -GroupName 'Prod web servers'

    Rename dependency group 12 of secret 1050, keeping its site

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretDependencyGroup -TssSession $session -Id 1050 -GroupId 12 -SiteId 3

    Run the dependencies of group 12 on site 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-dependencies/Update-TssSecretDependencyGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Update-TssSecretDependencyGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretDependencies.Group')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SecretId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [Alias('SecretDependencyGroupId')]
        [int]
        $GroupId,

        [ValidateNotNullOrEmpty()]
        [string]
        $GroupName,

        [ValidateRange(0, [int]::MaxValue)]
        [int]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if (-not ($tssParams.ContainsKey('GroupName') -or $tssParams.ContainsKey('SiteId'))) {
                Write-Error 'Provide -GroupName, -SiteId or both'
                return
            }
            $currentGroup = Get-TssSecretDependencyGroup -TssSession $TssSession -Id $Id -ErrorAction Stop | Where-Object Id -EQ $GroupId
            if (-not $currentGroup) {
                Write-Error "Dependency group [$GroupId] not found on Secret [$Id]"
                return
            }
            $newName = if ($tssParams.ContainsKey('GroupName')) { $GroupName } else { $currentGroup.Name }
            $newSiteId = if ($tssParams.ContainsKey('SiteId')) { $SiteId } else { $currentGroup.SiteId }
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-dependencies', 'groups', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{
                data = @{
                    secretDependencyGroupId   = $GroupId
                    secretDependencyGroupName = $newName
                    siteId                    = if ($newSiteId) { $newSiteId } else { $null }
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret dependency group: $GroupId on Secret: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretDependencyGroup request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretDependencies.Group]@{
                        Id                 = $restResponse.secretDependencyGroupId
                        Name               = $restResponse.name
                        SiteId             = [int]$restResponse.siteId
                        SiteName           = $restResponse.siteName
                        StatusFailedCount  = [int]$restResponse.statusFailedCount
                        StatusNotRunCount  = [int]$restResponse.statusNotRunCount
                        StatusSuccessCount = [int]$restResponse.statusSuccessCount
                        TotalDependencies  = [int]$restResponse.totalDependencies
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
