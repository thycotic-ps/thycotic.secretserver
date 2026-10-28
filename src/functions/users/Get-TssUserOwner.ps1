function Get-TssUserOwner {
    <#
    .SYNOPSIS
    Get the owners for a User ID

    .DESCRIPTION
    Get the owners of a User ID

    With -OwnerId a single owner record is returned.

    .PARAMETER OwnerId
    ID of the owner record (the Id property of Get-TssUserOwner output)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserOwner -TssSession $session -Id 42

    Get Owners of the User ID 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserOwner -TssSession $session -Id 42 -OwnerId 3

    Get owner record 3 of the User ID 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserOwner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserOwner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'all')]
    [OutputType('Thycotic.PowerShell.Users.OwnerSummary[]')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("UserId")]
        [int[]]
        $Id,

        # Sort by specific property, default Id (user owner ID)
        [string]
        $SortBy = 'Id',

        [Parameter(Mandatory, ParameterSetName = 'owner')]
        [int]
        $OwnerId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $restResponse = $null
                if ($PSCmdlet.ParameterSetName -eq 'owner') {
                    $uri = $TssSession.ApiUrl, 'users', $user, 'owners', $OwnerId -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'

                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting owner [$OwnerId] on user [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.model) {
                        [Thycotic.PowerShell.Users.OwnerSummary](. $FilterTssResponse $restResponse.model ([Thycotic.PowerShell.Users.OwnerSummary]))
                    }
                    continue
                }
                $uri = $TssSession.ApiUrl, 'users', $user, 'owners' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting owners on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [Thycotic.PowerShell.Users.OwnerSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Users.OwnerSummary]))
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}