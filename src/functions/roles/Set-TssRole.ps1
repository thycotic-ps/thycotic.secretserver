function Set-TssRole {
    <#
    .SYNOPSIS
    Update the name or enabled state of a role

    .DESCRIPTION
    Changes the name or enabled state of a role and returns the updated role.
    Only the parameters you pass are sent. Omitted values stay unchanged.
    Use -Enabled:$false to disable a role.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Role ID

    .PARAMETER Enabled
    Enable the role. Use -Enabled:$false to disable it

    .PARAMETER Name
    New name for the role

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRole -TssSession $session -Id 7 -Enabled:$false

    Disables role ID 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssRole -TssSession $session -Id 7 -Name "Help Desk Tier 2"

    Renames role ID 7 to Help Desk Tier 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/Set-TssRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/Set-TssRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Roles.Role')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RoleId')]
        [int]
        $Id,

        [switch]
        $Enabled,

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
            $uri = $TssSession.ApiUrl, 'roles', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Role: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssRole request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Roles.Role](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Roles.Role]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
