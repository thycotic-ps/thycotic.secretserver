function Save-TssCustomCommand {
    <#
    .SYNOPSIS
    Create, update and delete the custom commands of a password type in one request

    .DESCRIPTION
    Saves a batch of changes to the custom commands of an editable password type in a single request: new commands (-Create), changed commands (-Update) and deleted commands (-DeleteId).
    Returns the custom commands of the password type after the save.
    Use New-TssCustomCommand, Update-TssCustomCommand and Remove-TssCustomCommand for one command at a time.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the password type whose commands are saved

    .PARAMETER Create
    Commands to create: objects or hashtables with CommandTypeCode, Command, Comment, Pause (milliseconds) and optionally Order

    .PARAMETER Update
    Commands to update: objects or hashtables with CustomCommandId, CommandTypeCode, Command, Comment, Order and Pause, for example the output of Search-TssCustomCommand after you changed it

    .PARAMETER DeleteId
    IDs of the custom commands to delete

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Save-TssCustomCommand -TssSession $session -Id 18 -Create @{ CommandTypeCode = 1; Command = 'show version'; Comment = 'Log the device version'; Pause = 1000 } -DeleteId 749

    Add one command to password type 18 and delete command 749 in the same request

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $commands = Search-TssCustomCommand -TssSession $session -Id 18
    $commands | ForEach-Object { $_.Pause = 2000 }
    Save-TssCustomCommand -TssSession $session -Id 18 -Update $commands

    Set a two second pause on every command of password type 18

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Save-TssCustomCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Save-TssCustomCommand.ps1

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
        [Alias('PasswordTypeId')]
        [int]
        $Id,

        [object[]]
        $Create,

        [object[]]
        $Update,

        [int[]]
        $DeleteId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'custom-commands', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $creates = @(
                foreach ($item in $Create) {
                    $newCommand = @{
                        commandTypeCode = [int]$item.CommandTypeCode
                        command         = $item.Command
                        comment         = $item.Comment
                        pause           = [int]$item.Pause
                    }
                    if ($null -ne $item.Order) {
                        $newCommand.Add('order', [int]$item.Order)
                    }
                    $newCommand
                }
            )
            $updates = @(
                foreach ($item in $Update) {
                    @{
                        customCommandId = [int]$item.CustomCommandId
                        commandTypeCode = [int]$item.CommandTypeCode
                        command         = $item.Command
                        comment         = $item.Comment
                        order           = [int]$item.Order
                        pause           = [int]$item.Pause
                    }
                }
            )
            $body = @{
                creates   = $creates
                updates   = $updates
                deleteIds = @($DeleteId | Where-Object { $null -ne $_ })
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Custom commands of password type: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                $restResponse = $null
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Save-TssCustomCommand request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Rpc.CustomCommand[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Rpc.CustomCommand]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
