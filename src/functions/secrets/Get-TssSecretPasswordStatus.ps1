function Get-TssSecretPasswordStatus {
    <#
    .SYNOPSIS
    Get status of password change

    .DESCRIPTION
    Get status of password change

    .PARAMETER RestApi
    Read the status from the public REST route (secrets/secret-detail/{id}/password-status) instead of the internal route

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPasswordStatus -TssSession $session -Id 26

    Get password change status of Secret ID 26

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPasswordStatus -TssSession $session -Id 26 -RestApi

    Get password change status of Secret ID 26 from the public REST route

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretPasswordStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretPasswordStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.PasswordStatus')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [switch]
        $RestApi
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        if (-not $RestApi) {
            Write-TssInternalNote $PSCmdlet.MyInvocation
        }
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                if ($RestApi) {
                    $uri = $TssSession.ApiUrl, 'secrets', 'secret-detail', $secret, 'password-status' -join '/'
                } else {
                    $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $secret, 'password-status' -join '/'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse @apiResponse
                } catch {
                    Write-Warning "Issue getting password status on Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.status -ne 'None') {
                    [Thycotic.PowerShell.Secrets.PasswordStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.PasswordStatus]))
                } else {
                    Write-Host "No active password change found on Secret [$secret]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}