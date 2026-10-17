function New-TssJumpboxRoute {
    <#
    .SYNOPSIS
    Create a jumpbox route

    .DESCRIPTION
    Creates a jumpbox route.
    Add its levels (hops) with New-TssJumpboxRouteLevel.
    Secret Server has no REST endpoint to delete a jumpbox route; deactivate one with Set-TssJumpboxRoute -Active:$false.
    Requires the Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the route as active. Without -Active the route is created inactive

    .PARAMETER Description
    Description of the route

    .PARAMETER Name
    Name of the route

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssJumpboxRoute -TssSession $session -Name 'DMZ via bastion' -Description 'Reach DMZ hosts through the bastion' -Active

    Creates an active jumpbox route

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $route = New-TssJumpboxRoute -TssSession $session -Name 'DMZ via bastion' -Active
    New-TssJumpboxRouteLevel -TssSession $session -Id $route.JumpboxRouteId -SecretId 42 -Port 22

    Creates a route and adds one hop that signs in with secret 42 on port 22

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/New-TssJumpboxRoute

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/New-TssJumpboxRoute.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [string]
        $Description,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'jumpbox-route' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'Description' {
                    $body.data.Add('description', $Description)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Jumpbox route", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssJumpboxRoute request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
