function Add-TssSecretPermission {
    <#
    .SYNOPSIS
    Add a User or Group permission to a Secret

    .DESCRIPTION
    Add a User or Group permission to a Secret. Use -Force to break inheritance.

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssSecretPermission -TssSession $session -Id 65 -Type User -Name bob -AccessRole Owner

    Add bob to Secret 65 granting Secret role of owner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secrets = Search-TssSecret -TssSession $session | Where-Object -not InheritPermission
    $secrets | Add-TssSecretPermission -TssSession $session -Username chance.wayne -AccessRole View

    Add "chance.wayne" to all Secrets that do not have Inherit Permissions enabled. Granting Secret role of View

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $Secrets = Search-TssSecret -TssSession $session -SearchText 'App'
    $Secrets | Add-TssSecretPermission -TssSession $session -Username chad -AccessRole Owner -Force

    Add "chad" as owner for Secrets that have "App" in their name, will also break inheritance if enabled on any of the Secrets

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Secrets/Add-TssSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/Secrets/Add-TssSecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretPermission')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, ValueFromPipeline)]
        [int[]]
        $SecretId,

        # Secret Access Role Name (List, View, Edit, Owner)
        [Parameter(Mandatory, ValueFromPipeline)]
        [Thycotic.PowerShell.Enums.SecretPermissions]
        $AccessRole,

        #  Domain Name (the friendly name), if user or group is an Directory Service domain
        [Parameter()]
        [string]
        $DomainName,

        #  Group Name
        [Parameter(ValueFromPipeline)]
        [string]
        $GroupName,

        # Username
        [Parameter(ValueFromPipeline)]
        [string]
        $Username,

        # If provided will break inheritance on the secret and add the permission
        [Parameter()]
        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

            if ($tssParams.ContainsKey('Username')) {
                $users = Search-TssUser -TssSession $TssSession
                $username = $users.Where({ $_.Username -eq $Username }).Username
            }
            if ($tssParams.ContainsKey('Group')) {
                $groups = Search-TssGroup -TssSession $TssSession
                $groupName = $groups.Where({ $_.GroupName -eq $GroupName }).GroupName
            }

            if ($username.Count -gt 1) {
                Write-Warning "More than one matching Username was found, please provide a more unique name"
                return
            } elseif ($groupName.Count -gt 1) {
                Write-Warning "More than one matching Group Name was found, please provide a more unique name"
                return
            }

            if ($username -or $groupName) {
                $newSecretPermParams = @{
                    TssSession = $TssSession
                    SecretId   = $SecretId
                    DomainName = $DomainName
                    AccessRole = [string]$AccessRole
                }
                if ($username) {
                    $newSecretPermParams.Add('Username',$username)
                } elseif ($groupName) {
                    $newSecretPermParams.Add('GroupName',$groupName)
                }
                if ($tssParams.ContainsKey('Force')) {
                    $newSecretPermParams.Add('Force',$Force)
                }
                New-TssSecretPermission @newSecretPermParams
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}