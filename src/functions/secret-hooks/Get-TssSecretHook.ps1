function Get-TssSecretHook {
    <#
    .SYNOPSIS
    Get details of a Secret Hook

    .DESCRIPTION
    Get details of a Secret Hook

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretHook -TssSession $session -SecretId 376 -SecretHookId 1

    Get details of Secret Hook ID 1 of Secret ID 376

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Get-TssSecretHook

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-TssSecretHook.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretHooks.Hook')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [int]
        $SecretId,

        # Secret Hook ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('HookId')]
        [int]
        $SecretHookId
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
                $uri = $TssSession.ApiUrl, 'secret-detail', $SecretId, 'hook', 'get', $SecretHookId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Secret Hook [$SecretHookId] on Secret [$SecretId]"
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
                        ScriptId = $restResponse.scriptId.value
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
        } else {
            Write-Warning "No valid session found"
        }
    }
}