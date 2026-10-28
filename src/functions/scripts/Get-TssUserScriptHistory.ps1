function Get-TssUserScriptHistory {
    <#
    .SYNOPSIS
    Get an earlier version of a user script

    .DESCRIPTION
    Gets the script body saved by one change. ScriptName and ScriptType are the script's current name and type, not the values at that point.
    The ID is a script history ID, taken from the ScriptHistoryId property of Get-TssUserScriptAudit output.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Script history ID (ScriptHistoryId from Get-TssUserScriptAudit)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScriptHistory -TssSession $session -Id 327

    Get the script body saved by script history entry 327

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScriptAudit -TssSession $session -ScriptId 12 | Where-Object ScriptHistoryId | Get-TssUserScriptHistory -TssSession $session

    Get every saved version of user script 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScriptHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScriptHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Scripts.UserScriptHistory')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScriptHistoryId')]
        [int[]]
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
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'userscripts', 'history', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssUserScriptHistory request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Scripts.UserScriptHistory](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Scripts.UserScriptHistory]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
