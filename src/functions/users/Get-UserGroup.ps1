function Get-UserGroup {
    <#
    .SYNOPSIS
    Get the groups of a user by ID

    .DESCRIPTION
    Get the groups of a user by ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserGroup -TssSession $session -Id 42

    Get group the User ID 42 is a member of

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssUserGroup')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # User ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        # Sort by specific property, default GroupId
        [string]
        $SortBy = 'GroupId'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'groups' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting group(s) on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [TssGroupUserSummary[]]$restREsponse.records
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}