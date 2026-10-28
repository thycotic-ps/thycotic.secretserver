function Remove-TssCustomCommand {
    <#
    .SYNOPSIS
    Delete a custom command

    .DESCRIPTION
    Deletes custom commands from their password type. Find command IDs with Search-TssCustomCommand.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the custom command to delete

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssCustomCommand -TssSession $session -Id 749

    Delete custom command 749

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssCustomCommand -TssSession $session -Id 18 | Where-Object Comment -eq 'Log the device version' | Remove-TssCustomCommand -TssSession $session

    Delete the commands of password type 18 that carry the given comment

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Remove-TssCustomCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Remove-TssCustomCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CustomCommandId')]
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
                $uri = $TssSession.ApiUrl, 'remote-password-changing', 'custom-commands', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Custom command: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssCustomCommand request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Common.Delete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
