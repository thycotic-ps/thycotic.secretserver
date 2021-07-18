function Get-UserRoleAssigned {
    <#
    .SYNOPSIS
    Get roles assigned to User Id

    .DESCRIPTION
    Get roles assigned to User Id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserRoleAssigned -TssSession $session -UserId 254

    Returns roles assigned to the User ID 254

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserRoleAssigned

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-UserRoleAssigned.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    Only supported on 10.9.32 or higher of Secret Server
    #>
    [CmdletBinding()]
    [OutputType('TssUserRoleSummary')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $UserId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            foreach ($user in $UserId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'roles-assigned' -join '/'
                $uri = $uri, "take=$($TssSession.Take)" -join '?'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting User ID [$user]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records) {
                    [TssUserRoleSummary[]]$restResponse.records
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}