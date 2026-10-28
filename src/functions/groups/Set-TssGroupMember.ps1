function Set-TssGroupMember {
    <#
    .SYNOPSIS
    Add and remove group members in one request

    .DESCRIPTION
    Adds and removes users of a group in a single request. Only the users you list change; all other members stay.
    Update-TssGroupMember replaces the whole member list instead, and Add-TssGroupMember and Remove-TssGroupMember change one user per request.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER AddUserId
    User IDs to add to the group

    .PARAMETER RemoveUserId
    User IDs to remove from the group

    .PARAMETER AllowInactiveUsersUpdate
    Allow inactive users in AddUserId and RemoveUserId

    .PARAMETER ReturnValidationErrors
    Return validation errors for users that are not found

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssGroupMember -TssSession $session -Id 42 -AddUserId 17, 18 -RemoveUserId 99

    Adds users 17 and 18 to group 42 and removes user 99

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssGroupMember -TssSession $session -Id 42 -RemoveUserId 99 -ReturnValidationErrors

    Removes user 99 from group 42 and reports users that were not found

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Set-TssGroupMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Set-TssGroupMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Groups.MemberChangeStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int]
        $Id,

        [int[]]
        $AddUserId,

        [int[]]
        $RemoveUserId,

        [switch]
        $AllowInactiveUsersUpdate,

        [switch]
        $ReturnValidationErrors
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'groups', $Id, 'users' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ }
            switch ($tssParams.Keys) {
                'AddUserId' {
                    $body.Add('addedUserIds', $AddUserId)
                }
                'RemoveUserId' {
                    $body.Add('removeUserIds', $RemoveUserId)
                }
                'AllowInactiveUsersUpdate' {
                    $body.Add('allowInactiveUsersUpdate', [boolean]$AllowInactiveUsersUpdate)
                }
                'ReturnValidationErrors' {
                    $body.Add('returnValidationErrors', [boolean]$ReturnValidationErrors)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Group: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssGroupMember request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Groups.MemberChangeStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Groups.MemberChangeStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
