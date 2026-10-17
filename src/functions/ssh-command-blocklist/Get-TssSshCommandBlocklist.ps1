function Get-TssSshCommandBlocklist {
    <#
    .SYNOPSIS
    Get an SSH command blocklist

    .DESCRIPTION
    Returns the SSH command blocklist with the given ID and the blocked SSH commands on it.
    A blocklist stops the listed commands from running in proxied SSH sessions of secrets whose secret policy applies it.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SSH command blocklist ID (a GUID)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandBlocklist -TssSession $session -Id '3f2a9c7e-8b14-4d6a-a0c5-7e19b2d4f860'

    Returns the SSH command blocklist with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommandBlocklist -TssSession $session -Name 'Production' | Get-TssSshCommandBlocklist -TssSession $session

    Returns every blocklist with "Production" in the name, including the commands on each

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Get-TssSshCommandBlocklist

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Get-TssSshCommandBlocklist.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklist')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SshCommandBlocklistId')]
        [string[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'ssh-command-blocklist', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSshCommandBlocklist request'
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
