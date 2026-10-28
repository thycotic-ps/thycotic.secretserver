function Get-TssSshCommandStub {
    <#
    .SYNOPSIS
    Get a blank SSH command

    .DESCRIPTION
    Returns an SSH command with every field at its default value.
    It shows the fields New-TssSshCommand sets.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandStub -TssSession $session

    Returns a blank SSH command

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Get-TssSshCommandStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Get-TssSshCommandStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommand.SshCommand')]
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
            $uri = $TssSession.ApiUrl, 'ssh-command', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSshCommandStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SshCommand.SshCommand](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCommand.SshCommand]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
