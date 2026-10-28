function Remove-TssJumpboxRouteLevel {
    <#
    .SYNOPSIS
    Remove a level (hop) from a jumpbox route

    .DESCRIPTION
    Removes the level at the given position from the jumpbox route with the given ID.
    The levels after it move up one position, so when removing several levels remove the highest Order first.
    Returns True when the level was removed.
    Requires the Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .PARAMETER Order
    Position of the level on the route, starting at 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Order 2

    Removes the second hop from the route

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' | Sort-Object Order | Select-Object -Last 1 | Remove-TssJumpboxRouteLevel -TssSession $session

    Removes the last hop of the route

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Remove-TssJumpboxRouteLevel

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Remove-TssJumpboxRouteLevel.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('JumpboxRouteId')]
        [string]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Order
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'jumpbox-route', $Id, 'level', $Order -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("Jumpbox route level: $Id", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssJumpboxRouteLevel request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    $restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
