function New-TssSshCommandBlocklist {
    <#
    .SYNOPSIS
    Create an SSH command blocklist

    .DESCRIPTION
    Creates an SSH command blocklist from existing blocked SSH commands.
    Apply the blocklist to proxied SSH sessions through a secret policy.
    Secret Server has no REST endpoint to delete a blocklist; deactivate one with Set-TssSshCommandBlocklist -Active:$false.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the blocklist as active. Without -Active the blocklist is created inactive

    .PARAMETER Description
    Description of the blocklist

    .PARAMETER Name
    Name of the blocklist, unique among blocklists

    .PARAMETER SshCommandIds
    SshCommandGuid of each blocked SSH command to put on the list (at least one)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $blocked = Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked
    New-TssSshCommandBlocklist -TssSession $session -Name 'Production' -SshCommandIds $blocked.SshCommandGuid -Active

    Creates an active blocklist holding every blocked SSH command

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssSshCommandBlocklist -TssSession $session -Name 'No reboot' -SshCommandIds '9d47e2b1-5c03-4f8e-b6a2-1e7c0d93a4f5' -Description 'Blocks reboot'

    Creates an inactive blocklist with one blocked command

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/New-TssSshCommandBlocklist

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/New-TssSshCommandBlocklist.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklist')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [string]
        $Description,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'ssh-command-blocklist' -join '/'
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
                'SshCommandIds' {
                    $body.data.Add('sshCommandIds', $SshCommandIds)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Ssh command blocklist", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSshCommandBlocklist request'
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
