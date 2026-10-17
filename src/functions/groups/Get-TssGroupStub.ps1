function Get-TssGroupStub {
    <#
    .SYNOPSIS
    Get the default values for a new group

    .DESCRIPTION
    Returns a group object filled with the defaults Secret Server uses for a new group. Its Id is 0.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroupStub -TssSession $session

    Gets the default values for a new group

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroupStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroupStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.Group')]
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
            $uri = $TssSession.ApiUrl, 'groups', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssGroupStub request'
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
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
