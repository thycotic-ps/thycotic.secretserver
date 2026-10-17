function Set-TssJumpboxRouteLevel {
    <#
    .SYNOPSIS
    Change a level (hop) of a jumpbox route

    .DESCRIPTION
    Changes the position, port or secret of one level of the jumpbox route with the given ID.
    Only the parameters you pass are changed.
    Requires the Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .PARAMETER Order
    Current position of the level on the route, starting at 1

    .PARAMETER NewOrder
    New position for the level on the route, starting at 1

    .PARAMETER Port
    New port to connect to for this hop

    .PARAMETER SecretId
    ID of the new secret whose credentials sign in to this hop

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Order 1 -Port 2222

    Changes the port of the first hop to 2222

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Order 2 -NewOrder 1

    Moves the second hop to the front of the route

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Set-TssJumpboxRouteLevel

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Set-TssJumpboxRouteLevel.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.Level')]
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
        $Order,

        [int]
        $NewOrder,

        [int]
        $Port,

        [int]
        $SecretId
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
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'NewOrder' {
                    $body.data.Add('order', @{ dirty = $true; value = $NewOrder })
                }
                'Port' {
                    $body.data.Add('port', @{ dirty = $true; value = $Port })
                }
                'SecretId' {
                    $body.data.Add('secretId', @{ dirty = $true; value = $SecretId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Jumpbox route level: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssJumpboxRouteLevel request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.JumpboxRoute.Level](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.JumpboxRoute.Level]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
