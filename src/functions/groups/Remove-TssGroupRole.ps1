function Remove-TssGroupRole {
    <#
    .SYNOPSIS
    Remove roles from a group

    .DESCRIPTION
    Removes one or more roles from a group. Other roles of the group stay assigned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Group ID

    .PARAMETER RoleId
    Role IDs to remove from the group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssGroupRole -TssSession $session -Id 42 -RoleId 5

    Removes role 5 from group 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/groups/Remove-TssGroupRole

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/groups/Remove-TssGroupRole.ps1

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
                $uri = $TssSession.ApiUrl, 'groups', $currentId, 'roles' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                $body = @{ }
                switch ($tssParams.Keys) {
                    'RoleId' {
                        $body.Add('roleIds', $RoleId)
                    }
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Group: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssGroupRole request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Groups.RoleChangeStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Groups.RoleChangeStatus]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
