function Add-GroupMember {
    <#
    .SYNOPSIS
    Add a user to a group

    .DESCRIPTION
    Add a user to a group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssGroupMember -TssSession $session -Id 8 -UserId 54

    Add User ID 54 to Group ID 8

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Add-TssGroupMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Add-GroupMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'all')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Group ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int]
        $Id,

        # User Ids to add to the Group
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $UserId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $UserId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'groups', $Id, 'users' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $addBody = @{ userId = $user }
                $invokeParams.Body = $addBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("Group ID: $Id | User ID: $user", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $restResponse = . $InvokeApi @invokeParams
                    } catch {
                        Write-Warning 'Issue removing [$]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [TssGroupUser]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}