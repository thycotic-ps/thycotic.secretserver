function Set-TssSecretRpcPrivileged {
    <#
    .SYNOPSIS
    Set the Privileged Account for the RPC configuration on a Secret

    .DESCRIPTION
    Set the Privileged Account for the RPC configuration on a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretRpcPrivileged -TssSession $session -Id 46 -PrivilegedSecretId 276

    Set the RPC Privileged Account on Secret 46 to Secret 276

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretRpcPrivileged -TssSession $session -Id 56 -CredentialOnSecret

    Set the RPC Privileged Account on Secret 56 to use the Secret itself (Credentials on Secret)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretRpcPrivileged

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretRpcPrivileged.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Set Privileged Account to Use Credential on Secret
        [Parameter(ParameterSetName = 'secret')]
        [switch]
        $CredentialOnSecret,

        # Set Privileged Account to specific Secret ID
        [Parameter(ParameterSetName = 'privileged')]
        [Alias('PrivilegedSecret')]
        [int]
        $PrivilegedSecretId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-TssInternalNote $PSCmdlet.MyInvocation
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $secret, 'rpc' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $setRpcPrivBody = @{ data = @{ } }

                if ($setParams.ContainsKey('CredentialOnSecret')) {
                    $changeUsing = @{
                        dirty = $true
                        value = 'Secret'
                    }
                    $privilegedAccount = @{
                        dirty = $true
                        value = $null
                    }
                    $setRpcPrivBody.data.Add('changePasswordUsing', $changeUsing)
                    $setRpcPrivBody.data.Add('privilegedAccountSecretId', $privilegedAccount)
                }
                if ($setParams.ContainsKey('PrivilegedSecretId')) {
                    $changeUsing = @{
                        dirty = $true
                        value = 'PrivilegedAccount'
                    }
                    $privilegedAccount = @{
                        dirty = $true
                        value = $PrivilegedSecretId
                    }
                    $setRpcPrivBody.data.Add('changePasswordUsing', $changeUsing)
                    $setRpcPrivBody.data.Add('privilegedAccountSecretId', $privilegedAccount)
                }

                $invokeParams.Body = $setRpcPrivBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("Secret Id: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting privileged account on Secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    if ($setParams.ContainsKey('PrivilegedSecretId') -and $restResponse.privilegedAccountSecretId.value -eq $PrivilegedSecretId) {
                        Write-Verbose "Secret [$secret] RPC Privileged Secret set to [$PrivilegedSecretId]"
                    }
                    if ($setParams.ContainsKey('CredentialOnSecret') -and $null -eq $restResponse.privilegedAccountSecretId.value) {
                        Write-Verbose "Secret [$secret] RPC Privileged Secret set to use Credentials on Secret"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}