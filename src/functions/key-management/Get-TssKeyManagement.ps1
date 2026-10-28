function Get-TssKeyManagement {
    <#
    .SYNOPSIS
    Get the Key Management configuration

    .DESCRIPTION
    Gets the third-party key management provider that protects the Secret Server master encryption key (None, Amazon KMS or Azure Managed HSM) and its settings.
    Secret values are never returned: AwsKmsSecretAccessKey and AzureManagedHsmPrincipalSecret are always empty.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssKeyManagement -TssSession $session

    Get the Key Management configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssKeyManagement -TssSession $session).KeyManagementTypeName

    Show which key management provider is in use

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/key-management/Get-TssKeyManagement

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/key-management/Get-TssKeyManagement.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.KeyManagement.KeyManagement')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
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
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssKeyManagement request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.KeyManagement.KeyManagement](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.KeyManagement.KeyManagement]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
