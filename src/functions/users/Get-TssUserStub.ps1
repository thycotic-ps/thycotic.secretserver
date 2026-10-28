function Get-TssUserStub {
    <#
    .SYNOPSIS
    Get the default values for a new user

    .DESCRIPTION
    Returns a user object with the default values Secret Server uses for a new user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserStub -TssSession $session

    Returns the default values for a new user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Get-TssUserStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Get-TssUserStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Users.Stub')]
    param (
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
            $uri = $TssSession.ApiUrl, 'users', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssUserStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Users.Stub](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.Stub]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
