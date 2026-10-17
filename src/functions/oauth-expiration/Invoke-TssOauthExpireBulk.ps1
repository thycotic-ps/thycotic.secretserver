function Invoke-TssOauthExpireBulk {
    <#
    .SYNOPSIS
    Expire OAuth tokens by expiration record ID

    .DESCRIPTION
    Expire OAuth tokens in bulk by their expiration record ID, as returned by Search-TssOauthExpiration.
    The tokens stop working at once. Requires the Administer Users permission.
    IDs from the pipeline are sent in one request.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER OAuthExpirationId
    Expiration record ID (OAuthExpirationId from Search-TssOauthExpiration)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssOauthExpiration -TssSession $session -UserName 'svc-backup' | Invoke-TssOauthExpireBulk -TssSession $session

    Expires every API token issued to user svc-backup

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/oauth-expiration/Invoke-TssOauthExpireBulk

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/oauth-expiration/Invoke-TssOauthExpireBulk.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.OauthExpiration.ExpireResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [guid[]]
        $OAuthExpirationId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
        $expirationIds = [System.Collections.Generic.List[guid]]::new()
    }
    process {
        $expirationIds.AddRange($OAuthExpirationId)
    }
    end {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'oauth-expiration', 'expire-bulk' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    oAuthExpirationIds = $expirationIds.ToArray()
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("OAuth expiration records: $($expirationIds.Count)", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssOauthExpireBulk request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.OauthExpiration.ExpireResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.OauthExpiration.ExpireResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
