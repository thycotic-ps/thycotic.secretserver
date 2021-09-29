function Show-TssCurrentUser {
    <#
    .SYNOPSIS
    Show the current user of the current session

    .DESCRIPTION
    Show the current user of the current session

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Show-TssCurrentUser -TssSession $session

    Shows details on the current session's user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $currentUser = Show-TssCurrentUser -TssSession $session
    $currentUser.GetPermissions()

    Get the current user for the session and output a sorted list of Secret Server permissions assigned

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Show-TssCurrentUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Show-TssCurrentUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.CurrentUser')]
    param (
        # TssSession object created by New-TssSession for authentication
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', 'current' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue getting current user'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.Users.CurrentUser]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}