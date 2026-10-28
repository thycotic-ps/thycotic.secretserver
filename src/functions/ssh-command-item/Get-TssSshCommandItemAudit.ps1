function Get-TssSshCommandItemAudit {
    <#
    .SYNOPSIS
    Get the audit trail of SSH commands, blocklists and menus

    .DESCRIPTION
    Returns one entry per change made to an SSH command, SSH command blocklist or SSH command menu: who made it, when, the action, the commands before and after, and any notes.
    ItemType tells which kind of item an entry is about.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER NameOrNotes
    Return only entries whose item name or notes match this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandItemAudit -TssSession $session

    Returns every SSH command, blocklist and menu audit entry

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSshCommandItemAudit -TssSession $session -NameOrNotes 'Production'

    Returns the entries whose item name or notes contain "Production"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-item/Get-TssSshCommandItemAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-item/Get-TssSshCommandItemAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandItem.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $NameOrNotes
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-item', 'audit', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'NameOrNotes' {
                    $queryParams += "filter.sshCommandItemNameOrNotes=$([uri]::EscapeDataString($NameOrNotes))"
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
                Write-Warning 'Issue with Get-TssSshCommandItemAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCommandItem.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCommandItem.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
