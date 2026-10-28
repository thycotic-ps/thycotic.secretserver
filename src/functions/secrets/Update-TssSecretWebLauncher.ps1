function Update-TssSecretWebLauncher {
    <#
    .SYNOPSIS
    Update the web launcher settings of a secret

    .DESCRIPTION
    Set how the web launcher matches a secret URL to the page being filled in. Only valid for secrets whose template has the Website Login launcher. Returns the web launcher settings after the update; Secret Server includes them in its response only when its URL match type feature is on, otherwise the update is saved (and audited on the secret) and nothing is returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret Id

    .PARAMETER AutoCheckIn
    Automatically check in a secret after finding or updating

    .PARAMETER AutoCheckout
    Automatically check out secret before finding or updating

    .PARAMETER AutoComment
    Leave a comment when checking in or out

    .PARAMETER ForceCheckIn
    If secret is checked out, then force a check in

    .PARAMETER SecretUrlMatchType
    URL match type: Host, HostAndPath, Exact, BaseDomain or Never

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssSecretWebLauncher -TssSession $session -Id 42 -SecretUrlMatchType HostAndPath

    Match secret 42 on host and path

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Update-TssSecretWebLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretWebLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.WebLauncherSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $Id,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment,

        [switch]
        $ForceCheckIn,

        [Parameter(Mandatory)]
        [ValidateSet('Host', 'HostAndPath', 'Exact', 'BaseDomain', 'Never')]
        [string]
        $SecretUrlMatchType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', $Id, 'web-launcher-settings' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'AutoCheckIn' {
                    $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                }
                'AutoCheckout' {
                    $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                }
                'AutoComment' {
                    $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                }
                'ForceCheckIn' {
                    $queryParams += "forceCheckIn=$([boolean]$ForceCheckIn)"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'SecretUrlMatchType' {
                    $body.data.Add('secretUrlMatchType', @{ dirty = $true; value = $SecretUrlMatchType })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret web launcher: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssSecretWebLauncher request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.webLauncherSettings) {
                    [Thycotic.PowerShell.Secrets.WebLauncherSettings](. $FilterTssResponse $restResponse.webLauncherSettings ([Thycotic.PowerShell.Secrets.WebLauncherSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
