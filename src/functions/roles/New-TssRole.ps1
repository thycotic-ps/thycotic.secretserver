function New-TssRole {
    <#
    .SYNOPSIS
    Create a new role

    .DESCRIPTION
    Creates a role and returns it.
    A new role has no permissions. Add them with Update-TssRolePermission and assign groups with Set-TssRoleGroup.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Enabled
    Create the role enabled. Omit to create it disabled

    .PARAMETER Name
    Name of the new role, unique on the server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssRole -TssSession $session -Name "Help Desk" -Enabled

    Creates an enabled role named Help Desk

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/roles/New-TssRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/roles/New-TssRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Roles.Role')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Enabled,

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
            $uri = $TssSession.ApiUrl, 'roles' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                name    = $Name
                enabled = [boolean]$Enabled
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Role", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssRole request'
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
