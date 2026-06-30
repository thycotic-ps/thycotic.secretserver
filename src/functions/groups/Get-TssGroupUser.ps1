function Get-TssGroupUser {
    <#
    .SYNOPSIS
    Get a specific user's membership in a Group

    .DESCRIPTION
    Get the details of a single, specific user within a Group. Both the Group ID (-Id) and the User ID
    (-UserId) are required; this command verifies and returns one user's membership in the given Group.

    To list ALL users that are members of a Group, use Get-TssGroupMember instead.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroupUser -TssSession $session -Id 8 -UserId 43

    Get User Id 43 details in Group ID 8

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroupMember -TssSession $session -Id 8

    To list every member of a Group, use Get-TssGroupMember (not Get-TssGroupUser, which targets a single user)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupUser.ps1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupMember

    .NOTES
    Requires TssSession object returned by New-TssSession

    This command targets a single user via the groups/{id}/users/{userId} endpoint, so -UserId is mandatory.
    To enumerate all members of a Group use Get-TssGroupMember.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.User')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Group ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int]
        $Id,

        # User ID of the specific user to look up within the Group. Mandatory; to list all members of a Group use Get-TssGroupMember.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'groups', $Id, 'users', $UserId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting User [$UserId] on Group [$Id]. To list all members of a Group, use Get-TssGroupMember instead."
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Groups.User](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Groups.User]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}