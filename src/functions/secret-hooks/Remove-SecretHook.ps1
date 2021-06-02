function Remove-SecretHook {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Remove-TssSecretHook

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Remove-SecretHook.ps1

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
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($hook in $SecretHookId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-detail', $SecretId, 'hook', $hook -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if (-not $PSCmdlet.ShouldProcess("Secret ID: $SecretId | Hook ID: $hook","$($invokeParams.Method) $uri")) { return }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                    [TssDelete]@{
                        Id = $hook
                        ObjectType = 'Secret Hook'
                    }
                } catch {
                    Write-Warning "Issue removing hook [$hook] on Secret $SecretId"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}