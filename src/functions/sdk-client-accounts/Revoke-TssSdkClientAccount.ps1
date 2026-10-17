function Revoke-TssSdkClientAccount {
    <#
    .SYNOPSIS
    Revoke an SDK client account

    .DESCRIPTION
    Revoke one or more SDK client accounts so they can no longer authenticate. Returns true when revoked.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    SDK client account ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Revoke-TssSdkClientAccount -TssSession $session -Id 7

    Revokes SDK client account 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/sdk-client-accounts/Revoke-TssSdkClientAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/sdk-client-accounts/Revoke-TssSdkClientAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'sdk-client-accounts', $currentId, 'revoke' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                if ($PSCmdlet.ShouldProcess("Sdk client account: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Revoke-TssSdkClientAccount request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [System.Convert]::ToBoolean($restResponse)
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
