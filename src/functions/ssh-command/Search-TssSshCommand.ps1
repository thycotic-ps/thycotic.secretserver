function Search-TssSshCommand {
    <#
    .SYNOPSIS
    Search SSH commands

    .DESCRIPTION
    Returns the SSH commands that match the filters.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER CommandPermissionType
    Return only Allowed or only Blocked commands

    .PARAMETER NameOrCommand
    Return only commands whose name or command text matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommand -TssSession $session

    Returns every SSH command

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommand -TssSession $session -CommandPermissionType Blocked -NameOrCommand 'rm'

    Returns the blocked commands whose name or text contains "rm"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command/Search-TssSshCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command/Search-TssSshCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommand.SshCommand[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Allowed', 'Blocked')]
        [string]
        $CommandPermissionType,

        [string]
        $NameOrCommand
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command', 'list' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'CommandPermissionType' {
                    $queryParams += "filter.commandPermissionType=$([uri]::EscapeDataString($CommandPermissionType))"
                }
                'NameOrCommand' {
                    $queryParams += "filter.nameOrCommand=$([uri]::EscapeDataString($NameOrCommand))"
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
                Write-Warning 'Issue with Search-TssSshCommand request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCommand.SshCommand[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCommand.SshCommand]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
