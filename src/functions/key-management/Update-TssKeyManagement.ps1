function Update-TssKeyManagement {
    <#
    .SYNOPSIS
    Replace the Key Management configuration

    .DESCRIPTION
    Replaces the third-party key management provider that protects the Secret Server master encryption key, and its settings. The whole configuration is replaced: a setting you do not pass is cleared.
    Changing the provider re-protects the master encryption key with the new provider. Take a database and encryption key backup first.
    Requires a license that includes advanced encryption and the permission to edit Key Management. Refused in read-only mode, and while the last secret key rotation has not finished successfully.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AwsKmsAccessKeyId
    Amazon KMS access key id

    .PARAMETER AwsKmsKeyArn
    ARN of the Amazon KMS key that protects the master encryption key

    .PARAMETER AwsKmsSecretAccessKey
    Amazon KMS secret access key

    .PARAMETER AzureManagedHsmKeyUrl
    URL of the Azure Managed HSM key that protects the master encryption key

    .PARAMETER AzureManagedHsmPrincipalId
    Azure service principal (application) id used to reach the Managed HSM

    .PARAMETER AzureManagedHsmPrincipalSecret
    Azure service principal secret

    .PARAMETER AzureManagedHsmTenantId
    Azure tenant id of the service principal

    .PARAMETER KeyManagementTypeId
    Key management provider: 0 = None, 1 = Amazon KMS, 2 = Azure Managed HSM

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $awsSecret = Read-Host -AsSecureString
    Update-TssKeyManagement -TssSession $session -KeyManagementTypeId 1 -AwsKmsAccessKeyId AKIAEXAMPLEKEYID -AwsKmsSecretAccessKey $awsSecret -AwsKmsKeyArn arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab

    Protect the master encryption key with an Amazon KMS key

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssKeyManagement -TssSession $session -KeyManagementTypeId 0 -WhatIf

    Show the request that would remove the third-party key management provider, without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Update-TssKeyManagement

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Update-TssKeyManagement.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.KeyManagement.KeyManagement')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $AwsKmsAccessKeyId,

        [string]
        $AwsKmsKeyArn,

        [securestring]
        $AwsKmsSecretAccessKey,

        [string]
        $AzureManagedHsmKeyUrl,

        [string]
        $AzureManagedHsmPrincipalId,

        [securestring]
        $AzureManagedHsmPrincipalSecret,

        [string]
        $AzureManagedHsmTenantId,

        [Parameter(Mandatory)]
        [ValidateSet('0', '1', '2')]
        [int]
        $KeyManagementTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'key-management' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'AwsKmsAccessKeyId' {
                    $body.Add('awsKmsAccessKeyId', $AwsKmsAccessKeyId)
                }
                'AwsKmsKeyArn' {
                    $body.Add('awsKmsKeyArn', $AwsKmsKeyArn)
                }
                'AwsKmsSecretAccessKey' {
                    $body.Add('awsKmsSecretAccessKey', [System.Net.NetworkCredential]::new('', $AwsKmsSecretAccessKey).Password)
                }
                'AzureManagedHsmKeyUrl' {
                    $body.Add('azureManagedHsmKeyUrl', $AzureManagedHsmKeyUrl)
                }
                'AzureManagedHsmPrincipalId' {
                    $body.Add('azureManagedHsmPrincipalId', $AzureManagedHsmPrincipalId)
                }
                'AzureManagedHsmPrincipalSecret' {
                    $body.Add('azureManagedHsmPrincipalSecret', [System.Net.NetworkCredential]::new('', $AzureManagedHsmPrincipalSecret).Password)
                }
                'AzureManagedHsmTenantId' {
                    $body.Add('azureManagedHsmTenantId', $AzureManagedHsmTenantId)
                }
                'KeyManagementTypeId' {
                    $body.Add('keyManagementTypeId', $KeyManagementTypeId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Key management", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssKeyManagement request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.KeyManagement.KeyManagement](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.KeyManagement.KeyManagement]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
