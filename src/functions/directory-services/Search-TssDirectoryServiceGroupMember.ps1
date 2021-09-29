function Search-TssDirectoryServiceGroupMember {
    <#
    .SYNOPSIS
    Search Groups in a Directory Service for members

    .DESCRIPTION
    Search Groups in a Directory Service for members

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceGroupMember

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceGroupMember.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceGroupMember -TssSession $session -DomainId 4 -GroupName 'Secret Server Group 4'

    Return members of Group "Secret Server Group 4" from Domain ID 4

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.GroupMember')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Domain ID
        [Parameter(Mandatory)]
        [int]
        $DomainId,

        # Group Name
        [Parameter(Mandatory)]
        [Alias('Name')]
        [string]
        $GroupName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'directory-services', 'domains', $DomainId, 'members' -join '/'
            $uri = $uri, "groupName=$GroupName" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No DirectoryServiceGroupMember found"
            }
            if ($restResponse.members) {
                [Thycotic.PowerShell.DirectoryServices.GroupMember[]]$restResponse.members
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}