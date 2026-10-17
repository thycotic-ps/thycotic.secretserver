function Get-TssSshCommandMenu {
    <#
    .SYNOPSIS
    Get an SSH command menu

    .DESCRIPTION
    Returns the SSH command menu with the given ID.
    A command menu lists the commands a user may pick from when a secret policy limits a proxied SSH session to a menu.
    SshCommands holds the menu as one string of "name = command" lines.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH command menu ID (the integer SshCommandMenuId)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandMenu -TssSession $session -Id 3

    Returns the SSH command menu with ID 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSshCommandMenu -TssSession $session -Id 3).SshCommands -split "`r`n"

    Lists the "name = command" lines of the menu with ID 3, one per line

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenu

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenu.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandMenu.SshCommandMenu')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCommandMenuId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'ssh-command-menu', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSshCommandMenu request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SshCommandMenu.SshCommandMenu](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCommandMenu.SshCommandMenu]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
