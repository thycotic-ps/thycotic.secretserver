function Update-TssGroupRole {
    <#
    .SYNOPSIS
    Replace all roles of a group

    .DESCRIPTION
    Sets the roles of a group to exactly the roles given. Roles the group has that are not in RoleId are removed.
    Use Add-TssGroupRole to add roles without removing any.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER RoleId
    Role IDs the group should have. Roles not listed are removed

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssGroupRole -TssSession $session -Id 42 -RoleId 3

    Makes role 3 the only role of group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Update-TssGroupRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Update-TssGroupRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Uses the v2 roles endpoint, available from Secret Server 11.5.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Groups.RoleChangeStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('GroupId')]
        [int]
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
            Compare-TssVersion $TssSession '11.5.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'groups', $Id, 'roles' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'RoleId' {
                    $body.Add('roleIds', $RoleId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Group: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssGroupRole request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Groups.RoleChangeStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Groups.RoleChangeStatus]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
