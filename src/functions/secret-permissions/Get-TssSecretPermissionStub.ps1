function Get-TssSecretPermissionStub {
    <#
    .SYNOPSIS
    Get the default values for a new secret permission

    .DESCRIPTION
    Get the default values for a new secret permission on a secret (permission ID 0, no user or group, default secret role).
    Nothing is saved; use New-TssSecretPermission to add the permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretId
    Secret ID the new permission is for

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretPermissionStub -TssSession $session -SecretId 76

    Returns the default secret permission values for secret 76

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSecretPermissionStub -TssSession $session -SecretId 76).SecretAccessRoleName

    Returns the secret role a new permission on secret 76 gets by default

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Get-TssSecretPermissionStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Get-TssSecretPermissionStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretPermissions.Permission')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-permissions', 'stub' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'SecretId' {
                    $queryParams += "secretId=$($SecretId)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretPermissionStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.PSObject.Properties.Name -contains 'secretId') {
                [Thycotic.PowerShell.SecretPermissions.Permission](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretPermissions.Permission]))
            } elseif ($restResponse) {
                Write-Error "Secret Server did not return a secret permission stub for secret $SecretId; the secret does not exist or you cannot access it"
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
