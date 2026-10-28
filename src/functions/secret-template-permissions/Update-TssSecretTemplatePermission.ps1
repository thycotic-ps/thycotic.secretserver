function Update-TssSecretTemplatePermission {
    <#
    .SYNOPSIS
    Update the roles that groups hold on secret templates

    .DESCRIPTION
    Gives groups a secret template role, such as Template Owner or Template Create Secret. Search-TssSecretTemplatePermissionRole lists the role IDs. Both forms replace permissions rather than add to them.
    With -SecretTemplateId, replaces the secret template permissions of each group with the role on the given templates: the group loses its role on every template not listed. One request per group; returns the response of each request (GroupId and Permissions).
    With -Id, replaces the group permissions of one secret template with the groups given: groups not listed lose their role on the template. Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER GroupId
    Group IDs to give the role to

    .PARAMETER RoleId
    Secret template permission role ID, as returned by Search-TssSecretTemplatePermissionRole

    .PARAMETER SecretTemplateId
    Secret template IDs on which each group gets the role. Each group keeps no role on other templates

    .PARAMETER Id
    Secret template ID whose group permissions are replaced

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretTemplatePermission -TssSession $session -GroupId 4 -SecretTemplateId 6001, 6007 -RoleId 15

    Make templates 6001 and 6007 the only templates group 4 can create secrets from (role 15, Template Create Secret)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretTemplatePermission -TssSession $session -Id 6007 -GroupId 4, 5 -RoleId 16

    Make groups 4 and 5 the only groups with a role on template 6007, as Template Owner (role 16)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Update-TssSecretTemplatePermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Update-TssSecretTemplatePermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplatePermissions.GroupPermission', ParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Result', ParameterSetName = 'Template')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int[]]
        $GroupId,

        [Parameter(Mandatory)]
        [int]
        $RoleId,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Alias('TemplateId')]
        [int[]]
        $SecretTemplateId,

        [Parameter(Mandatory, ParameterSetName = 'Template')]
        [Alias('SecretTypeId')]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $requests = @(switch ($PSCmdlet.ParameterSetName) {
                'Template' {
                    $uri = $TssSession.ApiUrl, 'secret-template-permissions', $Id -join '/'
                    $permissions = @(foreach ($group in $GroupId) { @{ groupId = $group; roleId = $RoleId } })
                    @{ Uri = $uri; Target = "Secret template: $Id"; Body = @{ data = @{ permissions = $permissions } } }
                }
                default {
                    foreach ($group in $GroupId) {
                        $uri = $TssSession.ApiUrl, 'secret-template-permissions' -join '/'
                        $permissions = @(foreach ($template in $SecretTemplateId) { @{ secretTypeId = $template; roleId = $RoleId } })
                        @{ Uri = $uri; Target = "Group: $group"; Body = @{ groupId = $group; permissions = $permissions } }
                    }
                }
            })
            foreach ($request in $requests) {
                $restResponse = $null
                $invokeParams.Uri = $request.Uri
                $invokeParams.Method = 'PUT'
                $invokeParams.Body = $request.Body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess($request.Target, "$($invokeParams.Method) $($request.Uri) with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($request.Uri) with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Update-TssSecretTemplatePermission request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        if ($PSCmdlet.ParameterSetName -eq 'Template') {
                            [Thycotic.PowerShell.SecretTemplates.Result](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Result]))
                        } else {
                            [Thycotic.PowerShell.SecretTemplatePermissions.GroupPermission](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplatePermissions.GroupPermission]))
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
