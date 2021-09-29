function New-TssSecretHook {
    <#
    .SYNOPSIS
    Create a Secret Hook

    .DESCRIPTION
    Create a Secret Hook

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    $stub = Get-TssSecretHookStub -TssSession $session -SecretId 391 -ScriptId 6 -Name 'Test Hook' -PrePostOption PRE -EventAction CheckIn
    New-TssSecretHook -TssSession $session -SecretId 2 -SecretHookStub $stub

    Update Secret Hook 2's Arguments property on Secret ID 76

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/New-TssSecretHook

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/New-TssSecretHook.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretHooks.Hook')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory,ValueFromPipeline)]
        [Alias('Id')]
        [int[]]
        $SecretId,

        # Secret Hook Stub object
        [Parameter(Mandatory)]
        [Thycotic.PowerShell.SecretHooks.Hook]
        $SecretHookStub
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $SecretId) {
                $uri = $TssSession.ApiUrl, 'secret-detail', $secret, 'hook' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $hookParams = @()
                foreach ($hookParam in $SecretHooksStub.Parameters) {
                    $hookParams += @{
                        parameterName  = $hookParam.ParameterName
                        parameterType  = $hookParam.ParameterType
                        parameterValue = $hookParam.ParameterValue
                    }
                }
                $newHookBody = [ordered]@{ data = @{
                        arguments      = $SecretHookStub.Arguments
                        database       = $SecretHookStub.Database
                        description    = $SecretHookStub.Description
                        eventActionId  = $EventActionId
                        failureMessage = $SecretHookStub.FailureMessage
                        name           = $SecretHookStub.Name
                        parameters     = $hookParams
                        port = $SecretHookStub.Port
                        prePostOption = $SecretHookStub.PrePostOption
                        privilegedSecretId = $SecretHookStub.PrivilegedSecretId
                        scriptId = $SecretHookStub.ScriptId
                        secretId = $secret
                        serverKeyDigest = $SecretHookStub.ServerKeyDigest
                        serverName = $SecretHookStub.ServerName
                        sshKeySecretId = $SecretHookStub.SshKeySecretId
                        stopOnFailure = $SecretHookStub.StopOnFailure
                    }
                }
                $invokeParams.Body = ($newHookBody | ConvertTo-Json -Dept 100)

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $newHookBody"
                if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue creating report [SecretHook]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.SecretHooks.Hook]@{
                        SecretHookId = $restResponse.SecretHookId
                        HookId = $restResponse.HookId
                        Name = $restResponse.name.value
                        Description = $restResponse.description.value
                        SortOrder = $restResponse.sortOrder.value
                        PrePostOption = $restResponse.prePostOption.value
                        EventActionId = $restResponse.eventActionId.value
                        ScriptTypeId = $restResponse.scriptTypeId.value
                        ScriptId = $restResponse.ScriptId.value
                        Status = $restResponse.status.value
                        StopOnFailure = $restResponse.stopOnFailure.value
                        ServerName = $restResponse.serverName.value
                        ServerKeyDigest = $restResponse.serverKeyDigest.value
                        Port = $restResponse.port.value
                        Database = $restResponse.database.value
                        Arguments = $restResponse.arguments.value
                        SshKeySecretId = $restResponse.sshKeySecretId.value
                        PrivilegeSecretId = $restResponse.privilegeSecretId.value
                        Parameters = $restResponse.parameters
                        FailureMessage = $restResponse.failureMessage.value
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}