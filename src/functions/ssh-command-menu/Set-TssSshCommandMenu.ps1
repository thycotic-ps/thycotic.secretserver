function Set-TssSshCommandMenu {
    <#
    .SYNOPSIS
    Change an SSH command menu

    .DESCRIPTION
    Changes the SSH command menu with the given ID.
    Only the parameters you pass are changed. -SshCommands replaces the whole menu.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH command menu ID (the integer SshCommandMenuId)

    .PARAMETER Active
    Use -Active to activate the menu or -Active:$false to deactivate it

    .PARAMETER Description
    New description

    .PARAMETER Name
    New name

    .PARAMETER SshCommands
    The new menu entries: "name = command" lines joined with a carriage return and line feed; replaces the whole menu

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSshCommandMenu -TssSession $session -Id 3 -Active:$false

    Deactivates the menu with ID 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $menu = Get-TssSshCommandMenu -TssSession $session -Id 3
    Set-TssSshCommandMenu -TssSession $session -Id 3 -SshCommands ($menu.SshCommands.TrimEnd() + "`r`nUptime = uptime")

    Adds one entry to the end of the menu

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Set-TssSshCommandMenu

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Set-TssSshCommandMenu.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCommandMenu.SshCommandMenu')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCommandMenuId')]
        [int]
        $Id,

        [switch]
        $Active,

        [string]
        $Description,

        [string]
        $Name,

        [string]
        $SshCommands
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-menu', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('sshCommandMenuId', $Id)
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
                'SshCommands' {
                    $body.data.Add('sshCommands', @{ dirty = $true; value = $SshCommands })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh command menu: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSshCommandMenu request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SshCommandMenu.SshCommandMenu](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SshCommandMenu.SshCommandMenu]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
