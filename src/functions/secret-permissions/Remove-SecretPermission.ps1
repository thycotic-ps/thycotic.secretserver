function Remove-SecretPermission {
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
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-permissions/Remove-SecretPermission.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssDelete')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Permission ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretPermissionId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secretP in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-permissions', $secretP -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("Secret Permission ID: $secretP","$($invokeParams.Method) $uri")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue removing secret permission [$secretP]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssDelete]@{
                        Id = $restResponse.id
                        ObjectType = $restResponse.objectType
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}