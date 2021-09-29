function Get-TssGroup {
    <#
    .SYNOPSIS
    Get Group by ID

    .DESCRIPTION
    Get Group by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssGroup -TssSession $session -Id 8

    Get details on Group ID 8

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Get-TssGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Get-TssGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Groups.Group')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int[]]
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
            foreach ($group in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'groups', $group -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting group [$group]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    foreach ($g in $restResponse) {
                        if ($g.HasGroupOwners) {
                            $oGroups = @()
                            foreach ($prop in $g.ownerGroups.PSObject.Properties.Name) {
                                $oGroups += [pscustomobject]@{
                                    GroupId   = $prop
                                    GroupName = $g.ownerGroups.$prop
                                }
                            }
                            $oUsers = @()
                            foreach ($prop in $g.ownerUsers.PSObject.Properties.Name) {
                                $oUsers += [pscustomobject]@{
                                    UserId   = $prop
                                    Username = $g.ownerUsers.$prop
                                }
                            }
                        }

                        [Thycotic.PowerShell.Groups.Group]@{
                            AdGuid         = $g.AdGuid
                            CanEditMembers = $g.canEditMembers
                            Created        = $g.Created
                            DomainId       = $g.DomainId
                            DomainName     = $g.DomainName
                            Enabled        = $g.Enabled
                            HasGroupOwners = $g.HasGroupOwners
                            Id             = $g.Id
                            IsEditable     = $g.IsEditable
                            Name           = $g.Name
                            OwnerGroups    = $oGroups
                            Owners         = $g.Owners
                            OwnerUsers     = $oUsers
                            Synchronized   = $g.Synchronized
                            SynchronizeNow = $g.SynchronizeNow
                            SystemGroup    = $g.SystemGroup
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}