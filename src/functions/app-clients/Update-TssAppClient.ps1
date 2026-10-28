function Update-TssAppClient {
    <#
    .SYNOPSIS
    Update the redirect URI of an OAuth app client

    .DESCRIPTION
    Update the redirect URI of an existing OAuth app client.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    App client ID

    .PARAMETER RedirectUri
    New redirect URI for the app client

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssAppClient -TssSession $session -Id 2 -RedirectUri 'https://app.example.com/signin'

    Changes the redirect URI of app client 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/app-clients/Update-TssAppClient

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/app-clients/Update-TssAppClient.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.AppClients.AppClient')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

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
            $uri = $TssSession.ApiUrl, 'app-clients', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            $body.Add('id', $Id)
            switch ($tssParams.Keys) {
                'RedirectUri' {
                    $body.Add('redirectUri', $RedirectUri)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("App client: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssAppClient request'
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
