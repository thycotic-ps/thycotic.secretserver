function Get-TssUserScript {
    <#
    .SYNOPSIS
    Get a user script by ID, including its body and type settings

    .DESCRIPTION
    Gets one or more user scripts by ID through the v2 userscripts endpoint.
    Unlike Get-TssScript, the result carries the type settings in AdditionalData (powerShellSettings, sqlSettings or sshSettings) and the concurrency ID.
    UsageCount is always 0 because the server does not fill it in: use Get-TssUserScriptUsage to list where a script is used.
    ScriptType is returned as the type name (PowerShell, SQL or SSH).
    An ID with no matching script writes an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User script ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUserScript -TssSession $session -Id 12

    Get user script 12 with its body and type settings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssUserScript -TssSession $session -Id 12).AdditionalData.sqlSettings

    Show the database, port and parameters of SQL user script 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Get-TssUserScript

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Get-TssUserScript.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Scripts.ScriptItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScriptId')]
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
                $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'userscripts', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssUserScript request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -eq 'null') {
                    $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("User script $currentId not found"), 'UserScriptNotFound', 'ObjectNotFound', $currentId))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Scripts.ScriptItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Scripts.ScriptItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
