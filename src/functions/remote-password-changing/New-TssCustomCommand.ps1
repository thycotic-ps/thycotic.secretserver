function New-TssCustomCommand {
    <#
    .SYNOPSIS
    Create a custom command on a password type

    .DESCRIPTION
    Adds a custom command to an editable password type (CanEdit True, see Search-TssRpcPasswordType). Remote Password Changing runs the command for secrets that use the password type.
    Returns the new command, including its CustomCommandId.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER PasswordTypeId
    ID of the editable password type that gets the command

    .PARAMETER CommandTypeCode
    Command type code: 1 password change, 2 verify password (heartbeat), 3 password change with other credentials, 4 after a successful change, 5 after a failed change

    .PARAMETER Command
    Command text to run

    .PARAMETER Comment
    Comment shown with the command

    .PARAMETER Order
    Position in the command list. Omit to add the command at the end

    .PARAMETER Pause
    Pause after the command runs, in milliseconds

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssCustomCommand -TssSession $session -PasswordTypeId 18 -CommandTypeCode 1 -Command 'show version' -Comment 'Log the device version' -Pause 1000

    Add a command that logs the device version to password type 18, with a one second pause after it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssCustomCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssCustomCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Rpc.CustomCommand')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $PasswordTypeId,

        [Parameter(Mandatory)]
        [int]
        $CommandTypeCode,

        [Parameter(Mandatory)]
        [string]
        $Command,

        [string]
        $Comment,

        [int]
        $Order,

        [int]
        $Pause
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'custom-commands' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'PasswordTypeId' {
                    $body.Add('passwordTypeId', $PasswordTypeId)
                }
                'CommandTypeCode' {
                    $body.Add('commandTypeCode', $CommandTypeCode)
                }
                'Command' {
                    $body.Add('command', $Command)
                }
                'Comment' {
                    $body.Add('comment', $Comment)
                }
                'Order' {
                    $body.Add('order', $Order)
                }
                'Pause' {
                    $body.Add('pause', $Pause)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Custom command", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssCustomCommand request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Rpc.CustomCommand](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.CustomCommand]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
