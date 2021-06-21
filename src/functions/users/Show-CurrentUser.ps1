function Show-CurrentUser {
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
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Show-CurrentUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssCurrentUser')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'users', 'current' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning 'Issue getting current user'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssCurrentUser]$restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}