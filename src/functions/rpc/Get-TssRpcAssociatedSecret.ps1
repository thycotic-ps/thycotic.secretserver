function Get-TssRpcAssociatedSecret {
    <#
    .SYNOPSIS
    Get a list of the Associated Secrets configured for a Secret

    .DESCRIPTION
    Get a list of the Associated Secrets configured for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssRpcAssociatedSecret -TssSession $session - some test value

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/rpc/Get-TssRpcAssociatedSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rpc/Get-TssRpcAssociatedSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.AssociatedSecret')]
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
        Write-TssInternalNote $PSCmdlet.MyInvocation
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $secret, 'rpc' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Associated Secrets on Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.resetSecrets.value) {
                    foreach ($as in $restResponse.resetSecrets.value) {
                        [Thycotic.PowerShell.Rpc.AssociatedSecret]@{
                            ParentSecretId     = $secret
                            Order              = $as.order
                            AssociatedSecretId = $as.secretId
                            SecretName         = $as.secretName
                            SecretTemplateName = $as.secretTemplateName
                            FolderName         = $as.folderName
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}