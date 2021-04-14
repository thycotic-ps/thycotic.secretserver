function Get-SecretRpcAssociated {
    <#
    .SYNOPSIS
    Get a list of the Associated Secrets configured for a Secret

    .DESCRIPTION
    Get a list of the Associated Secrets configured for a Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretRpcAssociated -TssSession $session - some test value

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretRpcAssociated

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-SecretRpcAssociated.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretRpcAssociated')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        . $InternalEndpointUsed $PSCmdlet.MyInvocation
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl.Replace('api/v1','internals'), 'secret-detail', $secret, 'rpc' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting Associated Secrets on Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.resetSecrets.value) {
                    foreach ($as in $restResponse.resetSecrets.value) {
                        [TssSecretRpcAssociated]@{
                            ParentId = $secret
                            Order = $as.order
                            Id = $as.secretId
                            Name = $as.secretName
                            SecretTemplateName = $as.secretTemplateName
                            FolderName = $as.folderName
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}