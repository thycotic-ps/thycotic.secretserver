function Invoke-TssDpapiDecrypt {
    <#
    .SYNOPSIS
    Turn off DPAPI protection of the encryption key file

    .DESCRIPTION
    Stops protecting the Secret Server encryption key file (encryption.config) with Windows DPAPI and returns the resulting encryption state.
    This changes how the master encryption key is stored on the web server; it does not decrypt secrets or other data. The current user re-enters their own login password to confirm.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Password
    Login password of the current user, to confirm the change

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssDpapiDecrypt -TssSession $session -Password (Read-Host -AsSecureString)

    Turn off DPAPI protection of the encryption key file

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Invoke-TssDpapiDecrypt

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Invoke-TssDpapiDecrypt.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (Secret Server Cloud denies the request).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Configuration.DpapiState')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [securestring]
        $Password
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'dpapi', 'decrypt' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Password' {
                    $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Dpapi decrypt", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssDpapiDecrypt request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.DpapiState](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.DpapiState]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
