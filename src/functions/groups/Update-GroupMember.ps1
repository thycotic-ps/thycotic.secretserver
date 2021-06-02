function Update-GroupMember {
    <#
    .SYNOPSIS
    Update all members of a group

    .DESCRIPTION
    Update all members of a group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssGroupMember -TssSession $session -Id 8 -UserId 54, 35, 97, 345

    Update Group 8 to have users 54, 35, 97, and 345 as members

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssGroupMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-GroupMember.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'groups', $Id, 'users' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $addBody = @{ userId = $UserId }
            $invokeParams.Body = $addBody | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("Group ID: $Id", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning 'Issue updating Group [$Id]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    Write-Verbose "Group $Id updated successfully"
                } else {
                    Write-Warning "Group $Id was not updated, see previous output for errors"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}