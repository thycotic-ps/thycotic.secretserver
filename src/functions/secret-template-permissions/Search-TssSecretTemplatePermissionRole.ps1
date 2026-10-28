function Search-TssSecretTemplatePermissionRole {
    <#
    .SYNOPSIS
    Get the roles that can be assigned on secret templates

    .DESCRIPTION
    Returns the secret template permission roles, such as Template Owner and Template Create Secret, with their role IDs.
    Use a RoleId with Update-TssSecretTemplatePermission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretTemplatePermissionRole -TssSession $session

    List the secret template permission roles

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-template-permissions/Search-TssSecretTemplatePermissionRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-template-permissions/Search-TssSecretTemplatePermissionRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplatePermissions.Role[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-template-permissions', 'roles' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretTemplatePermissionRole request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretTemplatePermissions.Role[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplatePermissions.Role]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
