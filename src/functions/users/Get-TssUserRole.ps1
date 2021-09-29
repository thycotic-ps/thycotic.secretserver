function Get-TssUserRole {
    <#
    .SYNOPSIS
    Get roles for a user

    .DESCRIPTION
    Get roles for a user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserRole -TssSession $session -Id 2

    Get assigned roles for User ID 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.RoleSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
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
            foreach ($user in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'roles' -join '/'
                $uri = $uri, "take=$($TssSession.Take)" -join '?'

                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting roles on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records.Count -gt 0) {
                    [Thycotic.PowerShell.Users.RoleSummary[]]$restResponse.records
                } else {
                    Write-Warning "User ID [$user] not found"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}