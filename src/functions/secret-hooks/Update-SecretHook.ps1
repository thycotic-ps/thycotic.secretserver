function Update-SecretHook {
    <#
    .SYNOPSIS
    Update Secret Hook

    .DESCRIPTION
    Update Secret Hook

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Update-TssSecretHook -TssSession $session -SecretHookId 2 -SecretId 76

    Update Secret Hook 2's __ property on Secret ID 76

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssSecretHook

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Update-SecretHook.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

        # Secret Hook ID
        [Parameter(Manadatory)]
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

        # Event Action ID
        [int]
        $EventActionId,

        # Failure Message
        [string]
        $FailureMessage,

        # Name
        [string]
        $Name,

        # Port
        [string]
        $Port,

        # Pre Post Option
        [ValidateSet('PRE','POST')]
        [string]
        $PrePostOption
    )
    begin {
        $updateParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if (setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = null
            $uri = $TssSession.ApiUrl, 'endpoint' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'

            $updateBody = @{ data = @{} }
            switch ($updateParams.Keys) {
                'Arguments' {
                    $argumentValue = @{
                        dirty = $true
                        value = $Arguments
                    }
                    $updateBody.Add('arguments',$argumentValue)
                }
                'Database' {
                    $dbValue = @{
                        dirty = $true
                        value = $Database
                    }
                    $updateBody.Add('database',$dbValue)
                }
                'Description' {
                    $descValue = @{
                        dirty = $true
                        value = $Description
                    }
                    $updateBody.Add('description',$descValue)
                }
                'EventActionId' {
                    $eventValue = @{
                        dirty = $true
                        value = $EventActionId
                    }
                    $updateBody.Add('eventActionId',$eventValue)
                }
                'FailureMessage' {
                    $failureMsgValue = @{
                        dirty = $true
                        value = $FailureMessage
                    }
                    $updateBody.Add('failureMessage',$failureMsgValue)
                }
                'Name' {
                    $nameValue = @{
                        dirty = $true
                        value = $Name
                    }
                    $updateBody.Add('name',$nameValue)
                }
                'Port' {
                    $portValue = @{
                        dirty = $true
                        value = $Port
                    }
                    $updateBody.Add('port',$portValue)
                }
            }
            $invokeParams.Body = $addBody | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("description: $", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                Write-Verbose "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning 'Issue updating  [$]'
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    Write-Verbose " $ updated successfully"
                } else {
                    Write-Warning " $ was not updated, see previous output for errors"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}