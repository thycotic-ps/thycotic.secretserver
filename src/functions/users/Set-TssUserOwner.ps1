function Set-TssUserOwner {
    <#
    .SYNOPSIS
    Add or remove group owners of a user

    .DESCRIPTION
    Adds and removes groups as owners of a user in one call, or removes every owner so the user is managed by user administrators again.
    Add-TssUserOwner adds a single user or group owner.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER AddGroupId
    IDs of the groups to add as owners

    .PARAMETER RemoveAllOwners
    Remove every owner so the user is managed by user administrators

    .PARAMETER RemoveGroupId
    IDs of the groups to remove as owners

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUserOwner -TssSession $session -Id 42 -AddGroupId 8 -RemoveGroupId 9

    Adds group 8 and removes group 9 as owners of user 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUserOwner -TssSession $session -Id 42 -RemoveAllOwners

    Removes every owner of user 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Set-TssUserOwner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Set-TssUserOwner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int]
        $Id,

        [int[]]
        $AddGroupId,

        [switch]
        $RemoveAllOwners,

        [int[]]
        $RemoveGroupId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', $Id, 'owners' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            switch ($tssParams.Keys) {
                'AddGroupId' {
                    $body.Add('addedGroupIds', $AddGroupId)
                }
                'RemoveAllOwners' {
                    $body.Add('removeAllOwners', [boolean]$RemoveAllOwners)
                }
                'RemoveGroupId' {
                    $body.Add('removeGroupIds', $RemoveGroupId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssUserOwner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Users.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
