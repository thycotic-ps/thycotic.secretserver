function Get-UserRole {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssUserRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssRoleSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'users', $user, 'roles' -join '/'
                $uri = $uri, "take=$($TssSession.Take)" -join '?'

                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting roles on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records.Count -gt 0) {
                    [TssRoleSummary[]]$restResponse.records
                } else {
                    Write-Warning "User ID [$user] not found"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}