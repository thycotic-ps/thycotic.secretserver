function Get-TssSshCommandMenuAudit {
    <#
    .SYNOPSIS
    Get the audit trail of SSH command menus

    .DESCRIPTION
    Returns one entry per change made to an SSH command menu: who made it, when, the action, the commands before and after, and any notes.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SshCommandMenuName
    Return only entries for menus whose name matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandMenuAudit -TssSession $session

    Returns every SSH command menu audit entry

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandMenuAudit -TssSession $session -SshCommandMenuName 'Linux admins'

    Returns the audit entries for menus named like "Linux admins"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Get-TssSshCommandMenuAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Get-TssSshCommandMenuAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandMenu.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $SshCommandMenuName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-menu', 'audit', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'SshCommandMenuName' {
                    $queryParams += "filter.sshCommandMenuName=$([uri]::EscapeDataString($SshCommandMenuName))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSshCommandMenuAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCommandMenu.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCommandMenu.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
