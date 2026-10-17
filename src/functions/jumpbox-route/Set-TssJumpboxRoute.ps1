function Set-TssJumpboxRoute {
    <#
    .SYNOPSIS
    Change a jumpbox route

    .DESCRIPTION
    Changes the name, description or active state of the jumpbox route with the given ID.
    Only the parameters you pass are changed.
    Requires the Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .PARAMETER Active
    Use -Active to activate the route or -Active:$false to deactivate it

    .PARAMETER Description
    New description

    .PARAMETER Name
    New name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssJumpboxRoute -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e' -Name 'DMZ via bastion 2'

    Renames the route

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssJumpboxRoute -TssSession $session -SearchTerm 'Old DMZ' | Set-TssJumpboxRoute -TssSession $session -Active:$false

    Deactivates every active route with "Old DMZ" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Set-TssJumpboxRoute

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Set-TssJumpboxRoute.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.JumpboxRouteItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('JumpboxRouteId')]
        [string]
        $Id,

        [switch]
        $Active,

        [string]
        $Description,

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
            $uri = $TssSession.ApiUrl, 'jumpbox-route', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'Description' {
                    $body.data.Add('description', @{ dirty = $true; value = $Description })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Jumpbox route: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssJumpboxRoute request'
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
