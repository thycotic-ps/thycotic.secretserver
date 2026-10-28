function Get-TssSshCommand {
    <#
    .SYNOPSIS
    Get an SSH command

    .DESCRIPTION
    Returns the SSH command with the given ID.
    SSH commands are the allowed and blocked command lines that SSH command menus and SSH command blocklists use to control what a user can run in a proxied SSH session.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH command ID (the integer SshCommandId)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommand -TssSession $session -Id 12

    Returns the SSH command with ID 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked | Get-TssSshCommand -TssSession $session

    Returns every blocked SSH command

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Get-TssSshCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Get-TssSshCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommand.SshCommand')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCommandId')]
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
                $uri = $TssSession.ApiUrl, 'ssh-command', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSshCommand request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SshCommand.SshCommand](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCommand.SshCommand]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
