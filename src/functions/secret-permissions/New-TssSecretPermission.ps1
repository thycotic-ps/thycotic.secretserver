function New-TssSecretPermission {
    <#
    .SYNOPSIS
    Create a new Secret Permission

    .DESCRIPTION
    Create a new Secret Permission, use -Force to break inheritance

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSecretPermission -TssSession $session -SecretId 76 -AccessRole View -Username bob.martin

    Adding user "bob.martin" to Secret 76, granting View rights to the Secret.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secrets = Search-TssSecret -TssSession $session -SearchText 'Azure'
    New-TssSecretPermission -TssSession $session -SecretId $secrets.Id -AccessRole View -DomainName corp -GroupName 'IT Support' -Force

    Adding permission to all Secrets that have "Azure" in their name to the group "corp\IT Support" with View rights, breaking inheritance if enabled.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/New-TssSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/New-TssSecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretPermissions.Permission')]
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
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $SecretId) {
                $searchSecrets = Search-TssSecret $TssSession
                $secretInheritsPerm = $searchSecrets.Where({ $_.SecretId -eq $secret}).InheritsPermissions
                if (-not $secretInheritsPerm -or $tssNewParams.ContainsKey('Force')) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'secret-permissions' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'

                    $newBody = [ordered]@{
                        SecretAccessRoleName = [string]$AccessRole
                        SecretId             = $secret
                    }
                    switch ($tssNewParams.Keys) {
                        'DomainName' { $newBody.Add('domainName', $DomainName) }
                        'Username' { $newBody.Add('Username', $Username) }
                        'GroupName' { $newBody.Add('GroupName', $GroupName) }
                    }
                    $invokeParams.Body = ($newBody | ConvertTo-Json)

                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newBody"
                    if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue creating Secret Permission on secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.SecretPermissions.Permission]$restResponse
                    }
                } else {
                    Write-Error "Secret [$secret] has InheritPermissions enabled, use -Force parameter to break inheritance."
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}