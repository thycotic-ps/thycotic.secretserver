function Get-TssJumpboxRouteLevel {
    <#
    .SYNOPSIS
    Get the levels of a jumpbox route

    .DESCRIPTION
    Returns the levels (hops) of the jumpbox route with the given ID.
    Each level names the secret used to sign in to that hop and the port to connect to; Order is the position of the hop on the route, starting at 1.
    Secret Server returns at most 20 levels per route.
    Requires the View Jumpbox Route or Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Returns every level of the jumpbox route with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' | Sort-Object Order | Select-Object Order, SecretId, Port

    Lists the hops of the route in order with the secret and port each one uses

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRouteLevel

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRouteLevel.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.Level[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('JumpboxRouteId')]
        [string[]]
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
                $uri = $TssSession.ApiUrl, 'jumpbox-route', $currentId, 'level' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssJumpboxRouteLevel request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    foreach ($record in $restResponse.records) {
                        [Thycotic.PowerShell.JumpboxRoute.Level]@{
                            JumpboxRouteId = $record.jumpboxRouteId
                            Order          = $record.order.value
                            Port           = $record.port.value
                            SecretId       = $record.secretId.value
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
