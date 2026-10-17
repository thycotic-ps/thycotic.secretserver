function Get-TssSshCommandMenuState {
    <#
    .SYNOPSIS
    Get what the current user can do with SSH command menus

    .DESCRIPTION
    Returns the SSH command menu actions the signed-in user may take, such as CanCreate, and the ViewPolicy flag.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSshCommandMenuState -TssSession $session).Actions -contains 'CanCreate'

    Returns True when the signed-in user may create SSH command menus

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenuState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenuState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandMenu.State')]
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
            $uri = $TssSession.ApiUrl, 'ssh-command-menu', 'state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSshCommandMenuState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SshCommandMenu.State](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCommandMenu.State]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
