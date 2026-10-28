function Update-TssPasswordType {
    <#
    .SYNOPSIS
    Update a custom password type

    .DESCRIPTION
    Updates a password type. The server does not block changes to built-in password types that are not editable (CanEdit False): check CanEdit with Get-TssRpcPasswordType before you update by ID.
    By ID (-Id with field parameters): changes only the fields you pass; every other field stays as it is.
    By object (-PasswordType, or a password type piped in with no field parameters): replaces the whole password type with the object, typically the output of Get-TssRpcPasswordType after you changed its properties. The server resets any field it does not receive, so this parameter set only takes a complete password type object and refuses one with no Name or with CanEdit False.
    Script and LDAP settings IDs of 0 are sent as none.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the password type to update

    .PARAMETER Name
    Password type name

    .PARAMETER Active
    Make the password type active (-Active) or inactive (-Active:$false)

    .PARAMETER CustomPort
    Custom network port, -1 for the default port

    .PARAMETER LineEnding
    Line ending sent after each command

    .PARAMETER UseUsernameAndPassword
    Whether the password type uses both the username and the password

    .PARAMETER IgnoreSSL
    Whether certificate errors are ignored

    .PARAMETER UseSSL
    Whether the connection uses SSL

    .PARAMETER ValidForTakeover
    Whether the password type is valid for account takeover

    .PARAMETER RequestTerminal
    Whether an SSH pseudo terminal is requested

    .PARAMETER RunnerType
    Password changer runner type

    .PARAMETER ExitCommand
    Command sent to end the session

    .PARAMETER WindowsCustomPorts
    Custom ports for Windows password changers

    .PARAMETER OdbcConnectionString
    ODBC connection string

    .PARAMETER MainframeConnectionString
    Mainframe connection string

    .PARAMETER RpcScriptId
    ID of the script that changes the password

    .PARAMETER RpcScriptArgs
    Arguments of the password change script

    .PARAMETER HeartbeatScriptId
    ID of the script that runs heartbeat

    .PARAMETER HeartbeatScriptArgs
    Arguments of the heartbeat script

    .PARAMETER PasswordType
    Complete password type object, as returned by Get-TssRpcPasswordType

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssPasswordType -TssSession $session -Id 79 -CustomPort 2222 -LineEnding CarriageReturnNewLine

    Change only the port and the line ending of password type 79

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $type = Get-TssRpcPasswordType -TssSession $session -Id 79
    $type.ExitCommand = 'exit'
    $type | Update-TssPasswordType -TssSession $session

    Replace password type 79 with its current settings plus a new exit command

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Update-TssPasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Update-TssPasswordType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Setting names from the REST model, not a credential pair')]
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'object')]
    [OutputType('Thycotic.PowerShell.Rpc.PasswordType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'field')]
        [Alias('PasswordTypeId')]
        [int]
        $Id,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $Name,

        [Parameter(ParameterSetName = 'field')]
        [switch]
        $Active,

        [Parameter(ParameterSetName = 'field')]
        [int]
        $CustomPort,

        [Parameter(ParameterSetName = 'field')]
        [ValidateSet('NewLine', 'CarriageReturn', 'CarriageReturnNewLine')]
        [string]
        $LineEnding,

        [Parameter(ParameterSetName = 'field')]
        [switch]
        $UseUsernameAndPassword,

        [Parameter(ParameterSetName = 'field')]
        [switch]
        $IgnoreSSL,

        [Parameter(ParameterSetName = 'field')]
        [switch]
        $UseSSL,

        [Parameter(ParameterSetName = 'field')]
        [switch]
        $ValidForTakeover,

        [Parameter(ParameterSetName = 'field')]
        [switch]
        $RequestTerminal,

        [Parameter(ParameterSetName = 'field')]
        [ValidateSet('Standard', 'Legacy')]
        [string]
        $RunnerType,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $ExitCommand,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $WindowsCustomPorts,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $OdbcConnectionString,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $MainframeConnectionString,

        [Parameter(ParameterSetName = 'field')]
        [int]
        $RpcScriptId,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $RpcScriptArgs,

        [Parameter(ParameterSetName = 'field')]
        [int]
        $HeartbeatScriptId,

        [Parameter(ParameterSetName = 'field')]
        [string]
        $HeartbeatScriptArgs,

        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'object')]
        [Thycotic.PowerShell.Rpc.PasswordType[]]
        $PasswordType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
        $patchFields = @(
            'name', 'active', 'customPort', 'lineEnding', 'useUsernameAndPassword', 'ignoreSSL', 'useSSL', 'validForTakeover',
            'requestTerminal', 'runnerType', 'exitCommand', 'windowsCustomPorts', 'odbcConnectionString', 'mainframeConnectionString',
            'rpcScriptId', 'rpcScriptArgs', 'heartbeatScriptId', 'heartbeatScriptArgs'
        )
        $replaceFields = @(
            'name', 'canEdit', 'active', 'customPort', 'lineEnding', 'hasCommands', 'useUsernameAndPassword', 'isWeb', 'ignoreSSL',
            'useSSL', 'validForTakeover', 'rpcScriptArgs', 'heartbeatScriptArgs', 'runnerType', 'exitCommand', 'windowsCustomPorts',
            'odbcConnectionString', 'mainframeConnectionString'
        )
        $optionalIdFields = @('ldapConnectionSettingsId', 'scanItemTemplateId', 'rpcScriptId', 'heartbeatScriptId')
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $requests = [System.Collections.Generic.List[object]]::new()
            if ($PSCmdlet.ParameterSetName -eq 'object') {
                foreach ($currentType in $PasswordType) {
                    if (-not $currentType.CanEdit -or [string]::IsNullOrWhiteSpace($currentType.Name)) {
                        Write-Error "Password type [$($currentType.PasswordTypeId)] not sent: a full replace needs a complete, editable password type (CanEdit True and a Name), as returned by Get-TssRpcPasswordType"
                        continue
                    }
                    $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-types', $currentType.PasswordTypeId -join '/'
                    $body = @{ }
                    foreach ($field in $replaceFields) {
                        $body.Add($field, $currentType.$field)
                    }
                    foreach ($field in $optionalIdFields) {
                        $body.Add($field, $(if ($currentType.$field -gt 0) { $currentType.$field } else { $null }))
                    }
                    $requests.Add([pscustomobject]@{ Id = $currentType.PasswordTypeId; Uri = $uri; Body = $body })
                }
            } else {
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'remote-password-changing', 'password-types', $Id -join '/'
                $data = @{ }
                foreach ($field in $patchFields) {
                    if ($tssParams.ContainsKey($field)) {
                        $value = $tssParams[$field]
                        if ($value -is [switch]) {
                            $value = $value.IsPresent
                        }
                        $data.Add($field, @{ dirty = $true; value = $value })
                    }
                }
                $requests.Add([pscustomobject]@{ Id = $Id; Uri = $uri; Body = @{ data = $data } })
            }
            foreach ($request in $requests) {
                $restResponse = $null
                $invokeParams.Uri = $request.Uri
                $invokeParams.Method = 'PUT'
                $invokeParams.Body = $request.Body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Password type: $($request.Id)", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Update-TssPasswordType request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        if ($restResponse.fields) {
                            $restResponse.fields = @(
                                $restResponse.fields | ForEach-Object {
                                    [Thycotic.PowerShell.Rpc.PasswordTypeField](. $FilterTssResponse $_ ([Thycotic.PowerShell.Rpc.PasswordTypeField]))
                                }
                            )
                        }
                        [Thycotic.PowerShell.Rpc.PasswordType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.PasswordType]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
