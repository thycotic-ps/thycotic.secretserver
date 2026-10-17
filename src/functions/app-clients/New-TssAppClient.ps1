function New-TssAppClient {
    <#
    .SYNOPSIS
    Create a new OAuth app client

    .DESCRIPTION
    Create a new OAuth app client with the given redirect URI. The server generates the client ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER RedirectUri
    Redirect URI allowed for the app client

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssAppClient -TssSession $session -RedirectUri 'https://app.example.com/callback'

    Creates an app client that redirects to https://app.example.com/callback

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/New-TssAppClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/New-TssAppClient.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.AppClients.AppClient')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $RedirectUri
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'app-clients' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'RedirectUri' {
                    $body.Add('redirectUri', $RedirectUri)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("App client", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssAppClient request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.AppClients.AppClient](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AppClients.AppClient]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
