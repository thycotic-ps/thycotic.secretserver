function Update-TssCustomCommand {
    <#
    .SYNOPSIS
    Update a custom command

    .DESCRIPTION
    Updates a custom command of an editable password type. The server replaces the whole command, so any of -CommandTypeCode, -Command, -Comment, -Order, -Pause and -ConcurrencyId you do not pass is copied from the current command (read with Search-TssCustomCommand, one extra request).
    Piping the output of Search-TssCustomCommand binds every field, so no extra request is made.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the custom command to update

    .PARAMETER PasswordTypeId
    ID of the password type the command belongs to

    .PARAMETER CommandTypeCode
    Command type code: 1 password change, 2 verify password (heartbeat), 3 password change with other credentials, 4 after a successful change, 5 after a failed change

    .PARAMETER Command
    Command text to run

    .PARAMETER Comment
    Comment shown with the command

    .PARAMETER Order
    Position in the command list

    .PARAMETER Pause
    Pause after the command runs, in milliseconds

    .PARAMETER ConcurrencyId
    Concurrency ID of the command, as returned by Search-TssCustomCommand

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssCustomCommand -TssSession $session -Id 749 -PasswordTypeId 18 -Comment 'Log the device version before the change'

    Change only the comment of custom command 749 of password type 18

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssCustomCommand -TssSession $session -Id 18 | Where-Object Command -eq 'show version' | Update-TssCustomCommand -TssSession $session -Pause 2000

    Set a two second pause on the matching commands of password type 18

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Update-TssCustomCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Update-TssCustomCommand.ps1

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
        [Alias('CustomCommandId')]
        [int]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $PasswordTypeId,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $CommandTypeCode,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $Command,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $Comment,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $Order,

        [Parameter(ValueFromPipelineByPropertyName)]
        [int]
        $Pause,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $ConcurrencyId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
        $commandFields = @('commandTypeCode', 'command', 'comment', 'order', 'pause', 'concurrencyId')
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $currentCommand = $null
            if (@($commandFields | Where-Object { -not $tssParams.ContainsKey($_) }).Count -gt 0) {
                $currentCommand = Search-TssCustomCommand -TssSession $TssSession -Id $PasswordTypeId | Where-Object CustomCommandId -EQ $Id
                if (-not $currentCommand) {
                    Write-Error "Custom command [$Id] not found on password type [$PasswordTypeId]"
                    return
                }
            }
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'custom-commands', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ passwordTypeId = $PasswordTypeId }
            foreach ($field in $commandFields) {
                $body.Add($field, $(if ($tssParams.ContainsKey($field)) { $tssParams[$field] } else { $currentCommand.$field }))
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Custom command: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                $restResponse = $null
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssCustomCommand request'
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
