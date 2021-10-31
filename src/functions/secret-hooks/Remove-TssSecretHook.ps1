function Remove-TssSecretHook {
    <#
    .SYNOPSIS
    Delete a Secret Hook

    .DESCRIPTION
    Delete a Secret Hook

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSecretHook -TssSession $session -SecretId 385 -SecretHookId 2

    Delete the Hook ID 2 on Secret ID 385

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-hooks/Remove-TssSecretHook

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Remove-TssSecretHook.ps1

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

        # Secret ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int]
        $SecretId,

        # Secret Hook ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("HookId")]
        [int[]]
        $SecretHookId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($hook in $SecretHookId) {
                $uri = $TssSession.ApiUrl, 'secret-detail', $SecretId, 'hook', $hook -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("Secret ID: $SecretId | Hook ID: $hook","$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        . $ProcessResponse $apiResponse >$null
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $hook
                            ObjectType = 'Secret Hook'
                        }
                    } catch {
                        Write-Warning "Issue removing hook [$hook] on Secret $SecretId"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}