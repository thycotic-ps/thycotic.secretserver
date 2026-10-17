function New-TssSshCommandMenu {
    <#
    .SYNOPSIS
    Create an SSH command menu

    .DESCRIPTION
    Creates an SSH command menu.
    SshCommands is one string of "name = command" lines separated by a carriage return and line feed.
    Secret Server has no REST endpoint to delete a menu; deactivate one with Set-TssSshCommandMenu -Active:$false.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the menu as active. Without -Active the menu is created inactive

    .PARAMETER Description
    Description of the menu

    .PARAMETER Name
    Name of the menu

    .PARAMETER SshCommands
    The menu entries: "name = command" lines joined with a carriage return and line feed

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSshCommandMenu -TssSession $session -Name 'Linux basics' -Description 'Read-only commands' -SshCommands ('List files = ls -la', 'Disk usage = df -h' -join "`r`n") -Active

    Creates an active menu with two commands

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/New-TssSshCommandMenu

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/New-TssSshCommandMenu.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCommandMenu.SshCommandMenu')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [string]
        $Description,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'ssh-command-menu' -join '/'
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
                'SshCommands' {
                    $body.data.Add('sshCommands', $SshCommands)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh command menu", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSshCommandMenu request'
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
