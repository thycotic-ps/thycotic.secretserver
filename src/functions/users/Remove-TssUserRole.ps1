function Remove-TssUserRole {
    <#
    .SYNOPSIS
    Remove roles from a user

    .DESCRIPTION
    Removes one or more roles from a user.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER RoleId
    IDs of the roles to remove

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssUserRole -TssSession $session -Id 42 -RoleId 3

    Removes role 3 from user 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Remove-TssUserRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Remove-TssUserRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [int[]]
        $RoleId
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
                $uri = $TssSession.ApiUrl, 'users', $currentId, 'roles' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                $body = @{ }
                switch ($tssParams.Keys) {
                    'RoleId' {
                        $body.Add('roleIds', $RoleId)
                    }
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("User: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssUserRole request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Users.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.ActionResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
