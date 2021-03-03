function Get-UserRole {
    <#
    .SYNOPSIS
    Get roles for a user

    .DESCRIPTION
    Get roles for a user

    .EXAMPLE
    PS> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS> Get-TssUserRole -TssSession $session -Id 2

    Get assigned roles for User ID 2

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssRoleSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]
       $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("UserRoleId")]
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
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting roles on user [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records.Count -gt 0) {
                    . $TssRoleSummaryObject $restResponse.records $user
                } else {
                    Write-Warning "User ID [$user] not found"
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}