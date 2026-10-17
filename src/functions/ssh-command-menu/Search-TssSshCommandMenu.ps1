function Search-TssSshCommandMenu {
    <#
    .SYNOPSIS
    Search SSH command menus

    .DESCRIPTION
    Returns the SSH command menus. Only active menus are returned unless you pass -IncludeDisabled.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeDisabled
    Include inactive menus

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommandMenu -TssSession $session

    Returns the active SSH command menus

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommandMenu -TssSession $session -IncludeDisabled | Get-TssSshCommandMenu -TssSession $session

    Returns the full details, commands included, of every menu

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-menu/Search-TssSshCommandMenu

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-menu/Search-TssSshCommandMenu.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandMenu.SshCommandMenuItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeDisabled
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-menu', 'search' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IncludeDisabled' {
                    $queryParams += "filter.includeDisabled=$([boolean]$IncludeDisabled)"
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
                Write-Warning 'Issue with Search-TssSshCommandMenu request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCommandMenu.SshCommandMenuItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCommandMenu.SshCommandMenuItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
