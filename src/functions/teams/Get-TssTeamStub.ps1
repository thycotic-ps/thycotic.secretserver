function Get-TssTeamStub {
    <#
    .SYNOPSIS
    Get the default values for a new team

    .DESCRIPTION
    Get a team object filled with the server's default values for a new team.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssTeamStub -TssSession $session

    Returns the default values for a new team

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/teams/Get-TssTeamStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/teams/Get-TssTeamStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Teams.Team')]
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
            $uri = $TssSession.ApiUrl, 'teams', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssTeamStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Teams.Team](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Teams.Team]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
