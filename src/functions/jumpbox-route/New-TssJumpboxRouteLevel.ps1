function New-TssJumpboxRouteLevel {
    <#
    .SYNOPSIS
    Add a level (hop) to a jumpbox route

    .DESCRIPTION
    Adds a level to the end of the jumpbox route with the given ID.
    Each level is one SSH hop: Secret Server signs in to the hop with the credentials of the given secret, on the given port.
    Requires the Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .PARAMETER Port
    Port to connect to for this hop

    .PARAMETER SecretId
    ID of the secret whose credentials sign in to this hop

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssJumpboxRouteLevel -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -SecretId 42 -Port 22

    Adds a hop that signs in with secret 42 on port 22 to the end of the route

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ via bastion' | New-TssJumpboxRouteLevel -TssSession $session -SecretId 57 -Port 2222

    Adds a second hop to the route found by name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/New-TssJumpboxRouteLevel

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/New-TssJumpboxRouteLevel.ps1

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

        [Parameter(Mandatory)]
        [int]
        $Port,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'jumpbox-route', $Id, 'level' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Port' {
                    $body.data.Add('port', $Port)
                }
                'SecretId' {
                    $body.data.Add('secretId', $SecretId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Jumpbox route level: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssJumpboxRouteLevel request'
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
