function Add-TssGroupRole {
    <#
    .SYNOPSIS
    Add roles to a group

    .DESCRIPTION
    Assigns one or more roles to a group. Roles the group already has stay assigned.
    Use Update-TssGroupRole to replace all roles of the group and Get-TssGroupRole to list them.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER RoleId
    Role IDs to add to the group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssGroupRole -TssSession $session -Id 42 -RoleId 3, 5

    Adds roles 3 and 5 to group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Add-TssGroupRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Add-TssGroupRole.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'groups', $Id, 'roles' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
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
                    Write-Warning 'Issue with Add-TssGroupRole request'
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
