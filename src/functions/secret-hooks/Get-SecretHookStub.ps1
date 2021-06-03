function Get-SecretHookStub {
    <#
    .SYNOPSIS
    Get stub for a new Secret Hook

    .DESCRIPTION
    Get stub for a new Secret Hook

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Get-TssSecretHookStub -TssSession $session -SecretId 391 -ScriptId 6

    Get stub for Secret ID 391 and Script 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretHookStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-hooks/Get-SecretHookStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretHook')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $SecretId,

        # Script ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $ScriptId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $SecretId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-detail', $secret, 'hook', 'stub', $ScriptId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting message"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssSecretHook]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}