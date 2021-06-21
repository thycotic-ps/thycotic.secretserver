function Get-SecretHookStub {
    <#
    .SYNOPSIS
    Get stub for a new Secret Hook

    .DESCRIPTION
    Get stub for a new Secret Hook

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Get-TssSecretHookStub -TssSession $session -SecretId 391 -ScriptId 6 -Name 'Test Hook' -PrePostOption PRE -EventAction CheckIn

    Get stub for Secret ID 391 and Script 6 with prepopulated settings for Name, PrePostOption and Event Action.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Get-TssSecretHookStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-SecretHookStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretHook')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $SecretId,

        # Script ID
        [Parameter(Mandatory)]
        [int]
        $ScriptId,

        # Name of Secret Hook
        [Parameter(Mandatory)]
        [string]
        $Name,

        # PRE/POST Option
        [Parameter(Mandatory)]
        [ValidateSet('PRE','POST')]
        [string]
        $PrePostOption,

        # Event Action, allowed: CheckIn, Checkout
        [ValidateSet('CheckIn','Checkout')]
        [string]
        $EventAction
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $SecretId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-detail', $secret, 'hook', 'stub', $ScriptId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting message"
                    $err = $_
                    . $ErrorHandling $err
                }

                switch ($EventAction) {
                    'Checkout' { $EventActionId = 10026 }
                    'CheckIn' { $EventActionId = 10025 }
                }
                if ($restResponse) {
                    [TssSecretHook]@{
                        SecretHookId = $restResponse.SecretHookId
                        HookId = $restResponse.HookId
                        Name = $Name
                        Description = $restResponse.description.value
                        SortOrder = $restResponse.sortOrder.value
                        PrePostOption = $PrePostOption
                        EventActionId = $EventActionId
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
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}