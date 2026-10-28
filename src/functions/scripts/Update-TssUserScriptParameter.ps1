function Update-TssUserScriptParameter {
    <#
    .SYNOPSIS
    Replace the parameters and type settings of a user script

    .DESCRIPTION
    Replaces the type settings block of a user script: PowerShell Core use for a PowerShell script, database, port, password changer and parameters for a SQL script, or port, line ending, environment use and parameters for an SSH script.
    This is a full replace, not a partial update: every setting of the block you do not pass is cleared, including the password changer of a SQL script and the parameter list. Read the current values with Get-TssUserScript (AdditionalData) first.
    The server applies only the block that matches the script type and ignores the others, so use the parameter set of that type.
    Requires the Administer Scripts permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User script ID

    .PARAMETER UsePowerShellCore
    PowerShell scripts: run the script under PowerShell Core, or under Windows PowerShell with -UsePowerShellCore:$false

    .PARAMETER SqlDatabase
    SQL scripts: database the script runs against

    .PARAMETER SqlPort
    SQL scripts: port used to connect

    .PARAMETER SqlPasswordChangerId
    SQL scripts: ID of the password changer the script uses to connect. Omitting it clears the password changer

    .PARAMETER SqlParameter
    SQL scripts: the complete parameter list; pass @() to clear it. Each item is a hashtable or object with parameterName and parameterDbType (a System.Data.DbType name such as Int32 or String), for example the items of AdditionalData.sqlSettings.parameters from Get-TssUserScript. Omitting it clears the parameter list

    .PARAMETER SshPort
    SSH scripts: port used to connect

    .PARAMETER SshLineEnding
    SSH scripts: line ending sent after each script line

    .PARAMETER SshDoNotUseEnvironment
    SSH scripts: do not use environment variables in the script

    .PARAMETER SshParameter
    SSH scripts: the complete parameter list; pass @() to clear it. Each item is a hashtable or object with parameterName and parameterSshType (Intrepreted or Literal), for example the items of AdditionalData.sshSettings.parameters from Get-TssUserScript. Omitting it clears the parameter list

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssUserScriptParameter -TssSession $session -Id 12 -UsePowerShellCore

    Run PowerShell user script 12 under PowerShell Core

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssUserScriptParameter -TssSession $session -Id 14 -SqlDatabase master -SqlPort 1433 -SqlPasswordChangerId 2 -SqlParameter @{ parameterName = '@id'; parameterDbType = 'Int32' }

    Set the database, port, password changer and one parameter of SQL user script 14

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssUserScriptParameter -TssSession $session -Id 15 -SshLineEnding CarriageReturnNewLine -SshParameter @{ parameterName = 'host'; parameterSshType = 'Literal' }

    Set the line ending and one parameter of SSH user script 15

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/scripts/Update-TssUserScriptParameter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/scripts/Update-TssUserScriptParameter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Scripts.ScriptItem')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ScriptId')]
        [int]
        $Id,

        [Parameter(ParameterSetName = 'powershell')]
        [switch]
        $UsePowerShellCore,

        [Parameter(ParameterSetName = 'sql')]
        [string]
        $SqlDatabase,

        [Parameter(ParameterSetName = 'sql')]
        [int]
        $SqlPort,

        [Parameter(ParameterSetName = 'sql')]
        [int]
        $SqlPasswordChangerId,

        [Parameter(ParameterSetName = 'sql')]
        [ValidateNotNull()]
        [object[]]
        $SqlParameter,

        [Parameter(ParameterSetName = 'ssh')]
        [int]
        $SshPort,

        [Parameter(ParameterSetName = 'ssh')]
        [ValidateSet('NewLine', 'CarriageReturn', 'CarriageReturnNewLine')]
        [string]
        $SshLineEnding,

        [Parameter(ParameterSetName = 'ssh')]
        [switch]
        $SshDoNotUseEnvironment,

        [Parameter(ParameterSetName = 'ssh')]
        [ValidateNotNull()]
        [object[]]
        $SshParameter
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'userscripts', $Id, 'parameters' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            switch ($PSCmdlet.ParameterSetName) {
                'powershell' {
                    $settings = @{ powerShellSettings = @{ usePowerShellCore = [boolean]$UsePowerShellCore } }
                }
                'sql' {
                    $sql = @{ parameters = @(foreach ($item in $SqlParameter) { @{ parameterName = $item.parameterName; parameterDbType = $item.parameterDbType } }) }
                    switch ($tssParams.Keys) {
                        'SqlDatabase' {
                            $sql.Add('database', $SqlDatabase)
                        }
                        'SqlPort' {
                            $sql.Add('port', $SqlPort)
                        }
                        'SqlPasswordChangerId' {
                            $sql.Add('passwordChangerId', $SqlPasswordChangerId)
                        }
                    }
                    $settings = @{ sqlSettings = $sql }
                }
                'ssh' {
                    $ssh = @{ parameters = @(foreach ($item in $SshParameter) { @{ parameterName = $item.parameterName; parameterSshType = $item.parameterSshType } }) }
                    switch ($tssParams.Keys) {
                        'SshPort' {
                            $ssh.Add('port', $SshPort)
                        }
                        'SshLineEnding' {
                            $ssh.Add('lineEnding', $SshLineEnding)
                        }
                        'SshDoNotUseEnvironment' {
                            $ssh.Add('doNotUseEnvironment', [boolean]$SshDoNotUseEnvironment)
                        }
                    }
                    $settings = @{ sshSettings = $ssh }
                }
            }
            $invokeParams.Body = @{ data = $settings } | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("User script: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssUserScriptParameter request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Scripts.ScriptItem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Scripts.ScriptItem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
