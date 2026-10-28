function Set-TssSecretTemplatePasswordType {
    <#
    .SYNOPSIS
    Set the password changing settings of a secret template

    .DESCRIPTION
    Changes the password type (password changer), remote password changing and heartbeat settings, or field mappings of a secret template. Only the parameters you pass are changed.
    Secret Server saves a heartbeat interval only while heartbeat is enabled on the template, and the response can show the new interval even when it was not saved. Send -EnableHeartbeat with the interval parameters; the command warns when you do not.
    Returns the updated settings. Get-TssSecretTemplatePasswordType reads them back.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID

    .PARAMETER DefaultPrivilegedSecretId
    Secret ID of the default privileged account used to change passwords

    .PARAMETER EnableHeartbeat
    Enable heartbeat, or disable it with -EnableHeartbeat:$false

    .PARAMETER EnableRpc
    Enable remote password changing, or disable it with -EnableRpc:$false

    .PARAMETER FieldMapping
    Mapping of secret template field IDs (keys) to password type field IDs (values), for example @{ 108 = 32; 109 = 33 }

    .PARAMETER HeartbeatIntervalDays
    Days part of the heartbeat interval

    .PARAMETER HeartbeatIntervalHours
    Hours part of the heartbeat interval

    .PARAMETER HeartbeatIntervalMinutes
    Minutes part of the heartbeat interval. Secret Server rejects a total interval under 15 minutes, or under 60 minutes on Secret Server Cloud

    .PARAMETER PasswordTypeId
    Password type (password changer) ID to assign

    .PARAMETER RpcIntervalDays
    Days part of the remote password changing retry interval

    .PARAMETER RpcIntervalHours
    Hours part of the remote password changing retry interval

    .PARAMETER RpcIntervalMinutes
    Minutes part of the remote password changing retry interval

    .PARAMETER RpcMaxAttempts
    Maximum number of remote password changing attempts

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplatePasswordType -TssSession $session -Id 6007 -EnableHeartbeat -HeartbeatIntervalHours 4

    Enable heartbeat on template 6007 and run it every 4 hours

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplatePasswordType -TssSession $session -Id 6007 -RpcMaxAttempts 5

    Allow 5 remote password changing attempts for secrets of template 6007

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplatePasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplatePasswordType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.PasswordType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateId')]
        [int]
        $Id,

        [int]
        $DefaultPrivilegedSecretId,

        [switch]
        $EnableHeartbeat,

        [switch]
        $EnableRpc,

        [hashtable]
        $FieldMapping,

        [int]
        $HeartbeatIntervalDays,

        [int]
        $HeartbeatIntervalHours,

        [int]
        $HeartbeatIntervalMinutes,

        [int]
        $PasswordTypeId,

        [int]
        $RpcIntervalDays,

        [int]
        $RpcIntervalHours,

        [int]
        $RpcIntervalMinutes,

        [int]
        $RpcMaxAttempts
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $heartbeatIntervalParams = @('HeartbeatIntervalDays', 'HeartbeatIntervalHours', 'HeartbeatIntervalMinutes') | Where-Object { $tssParams.ContainsKey($_) }
            if ($heartbeatIntervalParams -and -not $tssParams.ContainsKey('EnableHeartbeat')) {
                Write-Warning 'Secret Server saves the heartbeat interval only while heartbeat is enabled on the template; pass -EnableHeartbeat with the interval and check the result with Get-TssSecretTemplatePasswordType'
            }
            $uri = $TssSession.ApiUrl, 'secret-templates', $Id, 'password-type' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DefaultPrivilegedSecretId' {
                    $body.data.Add('defaultPrivilegedSecretId', @{ dirty = $true; value = $DefaultPrivilegedSecretId })
                }
                'EnableHeartbeat' {
                    $body.data.Add('enableHeartbeat', @{ dirty = $true; value = [boolean]$EnableHeartbeat })
                }
                'EnableRpc' {
                    $body.data.Add('enableRpc', @{ dirty = $true; value = [boolean]$EnableRpc })
                }
                'FieldMapping' {
                    $mappings = @(foreach ($secretFieldId in $FieldMapping.Keys) {
                            @{
                                secretFieldId       = [int]$secretFieldId
                                passwordTypeFieldId = [int]$FieldMapping[$secretFieldId]
                            }
                        })
                    $body.data.Add('fields', @{ dirty = $true; value = $mappings })
                }
                'HeartbeatIntervalDays' {
                    $body.data.Add('heartbeatIntervalDays', @{ dirty = $true; value = $HeartbeatIntervalDays })
                }
                'HeartbeatIntervalHours' {
                    $body.data.Add('heartbeatIntervalHours', @{ dirty = $true; value = $HeartbeatIntervalHours })
                }
                'HeartbeatIntervalMinutes' {
                    $body.data.Add('heartbeatIntervalMinutes', @{ dirty = $true; value = $HeartbeatIntervalMinutes })
                }
                'PasswordTypeId' {
                    $body.data.Add('passwordTypeId', @{ dirty = $true; value = $PasswordTypeId })
                }
                'RpcIntervalDays' {
                    $body.data.Add('rpcIntervalDays', @{ dirty = $true; value = $RpcIntervalDays })
                }
                'RpcIntervalHours' {
                    $body.data.Add('rpcIntervalHours', @{ dirty = $true; value = $RpcIntervalHours })
                }
                'RpcIntervalMinutes' {
                    $body.data.Add('rpcIntervalMinutes', @{ dirty = $true; value = $RpcIntervalMinutes })
                }
                'RpcMaxAttempts' {
                    $body.data.Add('rpcMaxAttempts', @{ dirty = $true; value = $RpcMaxAttempts })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretTemplatePasswordType request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.PasswordType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.PasswordType]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
