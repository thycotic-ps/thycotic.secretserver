function Set-TssSshCommandBlocklist {
    <#
    .SYNOPSIS
    Change an SSH command blocklist

    .DESCRIPTION
    Changes the SSH command blocklist with the given ID.
    Only the parameters you pass are changed. -SshCommandIds replaces the whole set of commands on the list.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH command blocklist ID (a GUID)

    .PARAMETER Active
    Use -Active to activate the blocklist or -Active:$false to deactivate it

    .PARAMETER Description
    New description

    .PARAMETER Name
    New name

    .PARAMETER SshCommandIds
    SshCommandGuid of each blocked SSH command the list should hold; replaces the current set

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSshCommandBlocklist -TssSession $session -Id '3f2a9c7e-8b14-4d6a-a0c5-7e19b2d4f860' -Active

    Activates the blocklist

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $blocked = Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked
    Set-TssSshCommandBlocklist -TssSession $session -Id '3f2a9c7e-8b14-4d6a-a0c5-7e19b2d4f860' -SshCommandIds $blocked.SshCommandGuid

    Puts every blocked SSH command on the blocklist

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Set-TssSshCommandBlocklist

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Set-TssSshCommandBlocklist.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklist')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCommandBlocklistId')]
        [string]
        $Id,

        [switch]
        $Active,

        [string]
        $Description,

        [string]
        $Name,

        [string[]]
        $SshCommandIds
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-blocklist', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('sshCommandBlocklistId', $Id)
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
                'SshCommandIds' {
                    $body.data.Add('sshCommandIds', @{ dirty = $true; value = $SshCommandIds })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh command blocklist: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSshCommandBlocklist request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklist](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklist]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
