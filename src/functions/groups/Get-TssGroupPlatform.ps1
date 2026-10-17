function Get-TssGroupPlatform {
    <#
    .SYNOPSIS
    Get a group by its Platform or directory identifier

    .DESCRIPTION
    Gets a group by its AdGuid instead of its Secret Server ID. For a Delinea Platform group this is the Platform group ID.
    Returns the same object as Get-TssGroup. Groups without an AdGuid (local groups) cannot be found this way.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AdGuid
    AdGuid of the group: the Platform group ID for a Platform group, or the directory object GUID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroupPlatform -TssSession $session -AdGuid 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Gets the group whose AdGuid is df0b8746-581f-4ac2-a9b2-5a2b7a679f3e

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupPlatform

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupPlatform.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.Group')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        $AdGuid
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.6.000000' $PSCmdlet.MyInvocation
            foreach ($currentAdGuid in $AdGuid) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'groups', 'platform', $currentAdGuid -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssGroupPlatform request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    $ownerGroups = $null
                    $ownerUsers = $null
                    if ($restResponse.hasGroupOwners) {
                        $ownerGroups = foreach ($ownerGroupId in $restResponse.ownerGroups.PSObject.Properties.Name) {
                            [pscustomobject]@{
                                GroupId   = $ownerGroupId
                                GroupName = $restResponse.ownerGroups.$ownerGroupId
                            }
                        }
                        $ownerUsers = foreach ($ownerUserId in $restResponse.ownerUsers.PSObject.Properties.Name) {
                            [pscustomobject]@{
                                UserId   = $ownerUserId
                                Username = $restResponse.ownerUsers.$ownerUserId
                            }
                        }
                    }
                    [Thycotic.PowerShell.Groups.Group]@{
                        AdGuid         = $restResponse.adGuid
                        CanEditMembers = $restResponse.canEditMembers
                        Created        = $restResponse.created
                        DomainId       = $restResponse.domainId
                        DomainName     = $restResponse.domainName
                        Enabled        = $restResponse.enabled
                        HasGroupOwners = $restResponse.hasGroupOwners
                        Id             = $restResponse.id
                        IsEditable     = $restResponse.isEditable
                        Name           = $restResponse.name
                        OwnerGroups    = $ownerGroups
                        Owners         = $restResponse.owners
                        OwnerUsers     = $ownerUsers
                        Synchronized   = $restResponse.synchronized
                        SynchronizeNow = $restResponse.synchronizeNow
                        SystemGroup    = $restResponse.systemGroup
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
