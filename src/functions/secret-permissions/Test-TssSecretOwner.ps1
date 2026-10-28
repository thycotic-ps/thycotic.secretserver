function Test-TssSecretOwner {
    <#
    .SYNOPSIS
    Test whether you would still own a secret with the given permissions

    .DESCRIPTION
    Test whether the current user would be an owner of a secret if its permissions were the given groups and secret access roles. Returns true or false.
    Nothing is saved. Use it before replacing the permissions on a secret, so you do not remove your own owner access.
    Role IDs come from Get-TssSecretPermissionRoleOption.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER GroupId
    Group IDs of the proposed secret permissions

    .PARAMETER SecretAccessRoleId
    Secret access role IDs of the proposed secret permissions: one ID for every group, or one per group in the same order as GroupId

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $owner = (Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object Name -eq Owner).Id
    Test-TssSecretOwner -TssSession $session -GroupId 3 -SecretAccessRoleId $owner

    Returns true when Owner for group 3 would keep you an owner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $owner = (Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object Name -eq Owner).Id
    $view = (Get-TssSecretPermissionRoleOption -TssSession $session | Where-Object Name -eq View).Id
    Test-TssSecretOwner -TssSession $session -GroupId 3, 12 -SecretAccessRoleId $view, $owner

    Tests a set of two group permissions, View for group 3 and Owner for group 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Test-TssSecretOwner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Test-TssSecretOwner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int[]]
        $GroupId,

        [Parameter(Mandatory)]
        [int[]]
        $SecretAccessRoleId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-permissions', 'is-current-user-secret-owner' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($SecretAccessRoleId.Count -ne 1 -and $SecretAccessRoleId.Count -ne $GroupId.Count) {
                Write-Error 'Provide one SecretAccessRoleId, or one SecretAccessRoleId for each GroupId'
                return
            }
            $groupSecretAccessRoles = @()
            for ($i = 0; $i -lt $GroupId.Count; $i++) {
                $groupSecretAccessRoles += @{
                    groupId            = $GroupId[$i]
                    secretAccessRoleId = if ($SecretAccessRoleId.Count -eq 1) { $SecretAccessRoleId[0] } else { $SecretAccessRoleId[$i] }
                }
            }
            $body = @{ data = @{ groupSecretAccessRoles = $groupSecretAccessRoles } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssSecretOwner request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse.isCurrentUserSecretOwner) {
                [bool]$restResponse.isCurrentUserSecretOwner
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
