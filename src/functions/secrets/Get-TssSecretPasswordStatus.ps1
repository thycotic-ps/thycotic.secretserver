function Get-TssSecretPasswordStatus {
    <#
    .SYNOPSIS
    Get status of password change

    .DESCRIPTION
    Get status of password change
    Reads the published route GET secrets/secret-detail/{id}/password-status. Before 0.63.0 this command read the internal route internals/secret-detail/{id}/password-status, which is unsupported and can change in any Secret Server release; the output type is unchanged.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPasswordStatus -TssSession $session -Id 26

    Get password change status of Secret ID 26

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
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', 'secret-detail', $secret, 'password-status' -join '/'
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