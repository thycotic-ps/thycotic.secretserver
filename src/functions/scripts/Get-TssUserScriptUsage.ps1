function Get-TssUserScriptUsage {
    <#
    .SYNOPSIS
    Get where user scripts are used

    .DESCRIPTION
    Lists the places that use user scripts, such as password changers, dependency changers and discovery scanners.
    Returns one row per script and consumer, so a script used in several places appears once per place.
    Filter by script ID, script type or usage type.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ScriptId
    Only return usages of this user script ID

    .PARAMETER ScriptType
    Only return usages of scripts of this type

    .PARAMETER UsageType
    Only return usages of this type, for example DependencyChanger

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScriptUsage -TssSession $session -ScriptId 12

    List the places that use user script 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScriptUsage -TssSession $session -ScriptType SSH

    List where SSH user scripts are used

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptUsage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptUsage.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Scripts.UserScriptUsage[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $ScriptId,

        [ValidateSet('PowerShell', 'SQL', 'SSH')]
        [string]
        $ScriptType,

        [string]
        $UsageType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'userscripts', 'usage' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'ScriptId' {
                    $queryParams += "filter.scriptId=$($ScriptId)"
                }
                'ScriptType' {
                    $queryParams += "filter.scriptType=$([uri]::EscapeDataString($ScriptType))"
                }
                'UsageType' {
                    $queryParams += "filter.usageType=$([uri]::EscapeDataString($UsageType))"
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
                Write-Warning 'Issue with Get-TssUserScriptUsage request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Scripts.UserScriptUsage[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Scripts.UserScriptUsage]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
