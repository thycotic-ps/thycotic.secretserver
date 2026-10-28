function Get-TssUserScriptAudit {
    <#
    .SYNOPSIS
    Get the audit trail of user script changes

    .DESCRIPTION
    Lists user script audit entries: who created, viewed or changed which script, when, from which IP address, and what changed.
    Pass -ScriptId for the entries of one script; omit it for the entries of every script.
    ScriptHistoryId is set when the change saved a copy of the script body: pass it to Get-TssUserScriptHistory to read that version. It is 0 when the entry saved no body, such as a view or a parameter-only edit.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ScriptId
    Only return the audit entries of this user script ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScriptAudit -TssSession $session -ScriptId 12

    List the audit entries of user script 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScriptAudit -TssSession $session | Where-Object Action -EQ 'UPDATE'

    List every user script update

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Scripts.UserScriptAudit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $ScriptId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'userscripts', 'audit' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ScriptId' {
                    $queryParams += "filter.scriptId=$($ScriptId)"
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
                Write-Warning 'Issue with Get-TssUserScriptAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Scripts.UserScriptAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Scripts.UserScriptAudit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
