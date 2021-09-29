function Update-TssSecretHook {
    <#
    .SYNOPSIS
    Update Secret Hook

    .DESCRIPTION
    Update Secret Hook

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Update-TssSecretHook -TssSession $session -SecretHookId 2 -SecretId 76 -Arguments '$USERNAME $PASSWORD $DOMAIN'

    Update Secret Hook 2's Arguments property on Secret ID 76

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Update-TssSecretHook

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Update-TssSecretHook.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretHooks.Hook')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

        # Secret Hook ID
        [Parameter(Mandatory)]
        [int]
        $SecretHookId,

        # Arguments
        [string]
        $Arguments,

        # Database
        [string]
        $Database,

        # Description
        [string]
        $Description,

        # Event Action, allowed: CheckIn, Checkout
        [ValidateSet('CheckIn','Checkout')]
        [string]
        $EventAction,

        # Failure Message
        [string]
        $FailureMessage,

        # Name
        [string]
        $Name,

        # Port
        [string]
        $Port,

        # PRE/POST Option
        [ValidateSet('PRE','POST')]
        [string]
        $PrePostOption,

        # Privilege Secret ID
        [int]
        $PrivilegedSecretId,

        # Script ID
        [int]
        $ScriptId,

        # Script Type ID
        [int]
        $ScriptTypeId,

        # Server Key Digest
        [string]
        $ServerKeyDigest,

        # Server Name
        [string]
        $ServerName,

        # Sort Order
        [int]
        $SortOrder,

        # SSH Key Secret ID
        [int]
        $SshKeySecretId,

        # Status
        [boolean]
        $Status,

        # Stop On Failure
        [boolean]
        $StopOnFailure,

        # Parameter Name
        [Parameter(Mandatory, ParameterSetName = 'parameters')]
        [string]
        $ParameterName,

        # Parameter Value
        [Parameter(Mandatory, ParameterSetName = 'parameters')]
        [string]
        $ParameterValue,

        # Parameter Type, default 'Literal'
        [Parameter(ParameterSetName = 'parameters')]
        [string]
        $ParameterType = 'Literal'
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-detail', $SecretId, 'hook', $SecretHookId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $updateBody = @{ data = @{} }
            switch ($updateParams.Keys) {
                'Arguments' {
                    $argumentValue = @{
                        dirty = $true
                        value = $Arguments
                    }
                    $updateBody.data.Add('arguments',$argumentValue)
                }
                'Database' {
                    $dbValue = @{
                        dirty = $true
                        value = $Database
                    }
                    $updateBody.data.Add('database',$dbValue)
                }
                'Description' {
                    $descValue = @{
                        dirty = $true
                        value = $Description
                    }
                    $updateBody.data.Add('description',$descValue)
                }
                'EventAction' {
                    switch ($EventAction) {
                        'Checkout' { $EventActionId = 10026 }
                        'CheckIn' { $EventActionId = 10025 }
                    }
                    $eventValue = @{
                        dirty = $true
                        value = $EventActionId
                    }
                    $updateBody.data.Add('eventActionId',$eventValue)
                }
                'FailureMessage' {
                    $failureMsgValue = @{
                        dirty = $true
                        value = $FailureMessage
                    }
                    $updateBody.data.Add('failureMessage',$failureMsgValue)
                }
                'Name' {
                    $nameValue = @{
                        dirty = $true
                        value = $Name
                    }
                    $updateBody.data.Add('name',$nameValue)
                }
                'Port' {
                    $portValue = @{
                        dirty = $true
                        value = $Port
                    }
                    $updateBody.data.Add('port',$portValue)
                }
                'PrePostOption' {
                    $prePostValue = @{
                        dirty = $true
                        value = $PrePostOption
                    }
                    $updateBody.data.Add('prePostOption',$prePostValue)
                }
                'PrivilegedSecretId' {
                    $privSecretValue = @{
                        dirty = $true
                        value = $PrivilegedSecretId
                    }
                    $updateBody.data.Add('privilegedSecretId',$privSecretValue)
                }
                'ScriptId' {
                    $scriptIdValue = @{
                        dirty = $true
                        value = $ScriptId
                    }
                    $updateBody.data.Add('scriptId',$scriptIdValue)
                }
                'ScriptTypeId' {
                    $scriptTypeIdValue = @{
                        dirty = $true
                        value = $ScriptTypeId
                    }
                    $updateBody.data.Add('scriptTypeId',$scriptTypeIdValue)
                }
                'ServerKeyDigest' {
                    $serverKeyValue = @{
                        dirty = $true
                        value = $ServerKeyDigest
                    }
                    $updateBody.data.Add('serverKeyDigest',$serverKeyValue)
                }
                'ServerName' {
                    $serverNameValue = @{
                        dirty = $true
                        value = $ServerName
                    }
                    $updateBody.data.Add('serverName',$serverNameValue)
                }
                'SortOrder' {
                    $sortValue = @{
                        dirty = $true
                        value = $SortOrder
                    }
                    $updateBody.data.Add('serverName',$sortValue)
                }
                'SshKeySecretId' {
                    $sshSecretIdValue = @{
                        dirty = $true
                        value = $SshKeySecretId
                    }
                    $updateBody.data.Add('sshKeySecretId',$sshSecretIdValue)
                }
                'Status' {
                    $statusValue = @{
                        dirty = $true
                        value = [boolean]$Status
                    }
                    $updateBody.data.Add('status',$statusValue)
                }
                'Status' {
                    $stopFailureValue = @{
                        dirty = $true
                        value = [boolean]$StopOnFailure
                    }
                    $updateBody.data.Add('stopOnFailure',$stopFailureValue)
                }
                'ParameterName' {
                    # if one is provided all 3 are based on parameter set requirements
                    $parameterValues = [pscustomobject]@{
                        ParameterName = $ParameterName
                        ParameterType = $ParameterType
                        ParameterValue = $ParameterValue
                    }
                    $updateBody.data.Add('parameters',$parameterValues)
                }
            }
            $invokeParams.Body = $updateBody | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue updating Secret Hook [$SecretHookId] on Secret [$SecretId]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.SecretHooks.Hook]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}