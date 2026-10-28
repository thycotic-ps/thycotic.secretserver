function Set-TssSshCommand {
    <#
    .SYNOPSIS
    Change an SSH command

    .DESCRIPTION
    Changes the name or command text of the SSH command with the given GUID.
    Only the parameters you pass are changed. The permission type (Allowed or Blocked) cannot be changed.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH command GUID (SshCommandGuid), not the integer SshCommandId

    .PARAMETER Command
    New command line text

    .PARAMETER Name
    New display name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSshCommand -TssSession $session -Id '9d47e2b1-5c03-4f8e-b6a2-1e7c0d93a4f5' -Command 'ls -lah'

    Changes the command text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommand -TssSession $session -Id 12 | Set-TssSshCommand -TssSession $session -Name 'List all files'

    Renames the SSH command with ID 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Set-TssSshCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Set-TssSshCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCommand.SshCommand')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCommandGuid')]
        [string]
        $Id,

        [string]
        $Command,

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
            $uri = $TssSession.ApiUrl, 'ssh-command', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('sshCommandGuid', $Id)
            switch ($tssParams.Keys) {
                'Command' {
                    $body.data.Add('command', @{ dirty = $true; value = $Command })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh command: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSshCommand request'
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
