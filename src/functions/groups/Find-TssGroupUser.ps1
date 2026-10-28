function Find-TssGroupUser {
    <#
    .SYNOPSIS
    Get the display names of the members of a group

    .DESCRIPTION
    Returns the display names of the users in a group, as the web UI lists them. Use Get-TssGroupMember for full member records.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Find-TssGroupUser -TssSession $session -Id 42

    Gets the display names of the members of group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Find-TssGroupUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Find-TssGroupUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

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
            Compare-TssVersion $TssSession '11.2.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'groups', $currentId, 'users-lookup' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Find-TssGroupUser request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.users) {
                    [string[]]$restResponse.users
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
