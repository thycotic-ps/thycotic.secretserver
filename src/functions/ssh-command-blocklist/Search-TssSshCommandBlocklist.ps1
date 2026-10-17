function Search-TssSshCommandBlocklist {
    <#
    .SYNOPSIS
    Search SSH command blocklists

    .DESCRIPTION
    Returns the SSH command blocklists that match the filters, without the commands on each (use Get-TssSshCommandBlocklist for those).
    Only active blocklists are returned unless you pass -IncludeInactive.
    Requires the Administer SSH Menus role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeActive
    Include active blocklists. Active blocklists are included by default; use -IncludeActive:$false to leave them out

    .PARAMETER IncludeInactive
    Include inactive blocklists. Defaults to on when you pass -IncludeActive:$false, off otherwise

    .PARAMETER Name
    Return only blocklists whose name matches this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommandBlocklist -TssSession $session -IncludeInactive

    Returns every SSH command blocklist, active or not

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSshCommandBlocklist -TssSession $session -Name 'Production' -IncludeActive

    Returns the active blocklists with "Production" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ssh-command-blocklist/Search-TssSshCommandBlocklist

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ssh-command-blocklist/Search-TssSshCommandBlocklist.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklistItem[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeActive,

        [switch]
        $IncludeInactive,

        [string]
        $Name
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ssh-command-blocklist', 'list' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $includeActive = -not $tssParams.ContainsKey('IncludeActive') -or $IncludeActive.IsPresent
            $includeInactive = if ($tssParams.ContainsKey('IncludeInactive')) { $IncludeInactive.IsPresent } else { -not $includeActive }
            $queryParams += "filter.includeActive=$includeActive"
            $queryParams += "filter.includeInactive=$includeInactive"
            switch ($tssParams.Keys) {
                'Name' {
                    $queryParams += "filter.name=$([uri]::EscapeDataString($Name))"
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
                Write-Warning 'Issue with Search-TssSshCommandBlocklist request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklistItem[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.SshCommandBlocklist.SshCommandBlocklistItem]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
