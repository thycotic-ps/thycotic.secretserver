function Get-TssTicketSystemConfiguration {
    <#
    .SYNOPSIS
    Get the configured ticket systems

    .DESCRIPTION
    Returns the active ticket systems configured in Secret Server, one object per ticket system.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssTicketSystemConfiguration -TssSession $session

    Returns the active ticket systems

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssTicketSystemConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssTicketSystemConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.TicketSystem')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'ticket-system' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssTicketSystemConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                . $GetTicketSystem $restResponse
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
