function Get-TssAppState {
    <#
    .SYNOPSIS
    Get the application state of Secret Server

    .DESCRIPTION
    Returns the setup state of the Secret Server instance: Normal when it is ready to use, or a state such as CreateInitialUser, DatabaseConnectionError or ScheduledForDeletion.
    StatusText carries extra detail about the state. ProvisionDeletionDateTime is set when the instance is scheduled for deletion.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssAppState -TssSession $session

    Get the application state

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/app-state/Get-TssAppState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-state/Get-TssAppState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.AppState.Status')]
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
            $uri = $TssSession.ApiUrl, 'app-state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssAppState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.AppState.Status](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AppState.Status]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
