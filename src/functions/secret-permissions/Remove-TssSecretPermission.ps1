function Remove-TssSecretPermission {
    <#
    .SYNOPSIS
    Delete a Secret Permission

    .DESCRIPTION
    Delete a Secret Permission

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSecretPermission -TssSession $session -Id 231

    Delete the Secert Permissions 231

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-permissions/Remove-TssSecretPermission

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Remove-TssSecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Permission ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretPermissionId")]
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
            foreach ($secretP in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-permissions', $secretP -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("Secret Permission ID: $secretP","$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue removing secret permission [$secretP]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $restResponse.id
                            ObjectType = $restResponse.objectType
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}