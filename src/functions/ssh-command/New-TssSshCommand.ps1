function New-TssSshCommand {
    <#
    .SYNOPSIS
    Create an SSH command

    .DESCRIPTION
    Creates an SSH command: a named command line marked Allowed or Blocked.
    Allowed commands go into SSH command menus; blocked commands go into SSH command blocklists.
    Secret Server has no REST endpoint to delete an SSH command.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Command
    Command line text, unique within its permission type

    .PARAMETER CommandPermissionType
    Allowed (the default) or Blocked

    .PARAMETER Name
    Display name of the command, unique within its permission type

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSshCommand -TssSession $session -Name 'List files' -Command 'ls -la'

    Creates an allowed SSH command

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSshCommand -TssSession $session -Name 'Reboot' -Command 'reboot' -CommandPermissionType Blocked

    Creates a blocked SSH command, ready to add to a blocklist

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/New-TssSshCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/New-TssSshCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCommand.SshCommand')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Command,

        [ValidateSet('Allowed', 'Blocked')]
        [string]
        $CommandPermissionType,

        [Parameter(Mandatory)]
        [string]
        $Name
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Command' {
                    $body.data.Add('command', $Command)
                }
                'CommandPermissionType' {
                    $body.data.Add('commandPermissionType', $CommandPermissionType)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh command", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSshCommand request'
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
