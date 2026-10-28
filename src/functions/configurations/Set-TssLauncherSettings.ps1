function Set-TssLauncherSettings {
    <#
    .SYNOPSIS
    Update the launcher settings configuration

    .DESCRIPTION
    Update the launcher settings configuration (launcher on or off, deployment type, auto update, web launcher behavior, check in on close). Only the parameters you pass are changed. Returns the launcher settings after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER CheckInSecretOnLastLauncherClose
    Check in the secret when the user closes their only active launcher

    .PARAMETER CloseLauncherOnCheckInSecret
    Close every active launcher of a secret when the secret is checked in

    .PARAMETER EnableDomainDownload
    Allow users to download existing tested web launcher mappings

    .PARAMETER EnableDomainUpload
    Allow the user to upload mappings

    .PARAMETER EnableLauncher
    Enable launcher

    .PARAMETER EnableLauncherAutoUpdate
    Enable launcher auto update

    .PARAMETER EnableWebParsing
    Allow Secret Server to retrieve and parse the mapped website when using the web launcher

    .PARAMETER LauncherDeploymentType
    How launchers are deployed to the client: ProtocolHandler or ClickOnce

    .PARAMETER SendSecretUrlToLauncher
    Send the URL that is on the Secret to the web password launcher in addition to the bookmarklet

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssLauncherSettings -TssSession $session -EnableLauncherAutoUpdate:$false

    Turn off launcher auto update

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssLauncherSettings

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssLauncherSettings.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.LauncherSettings')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $CheckInSecretOnLastLauncherClose,

        [switch]
        $CloseLauncherOnCheckInSecret,

        [switch]
        $EnableDomainDownload,

        [switch]
        $EnableDomainUpload,

        [switch]
        $EnableLauncher,

        [switch]
        $EnableLauncherAutoUpdate,

        [switch]
        $EnableWebParsing,

        [ValidateSet('ClickOnce', 'ProtocolHandler')]
        [string]
        $LauncherDeploymentType,

        [switch]
        $SendSecretUrlToLauncher
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'launcher-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'CheckInSecretOnLastLauncherClose' {
                    $body.data.Add('checkInSecretOnLastLauncherClose', @{ dirty = $true; value = [boolean]$CheckInSecretOnLastLauncherClose })
                }
                'CloseLauncherOnCheckInSecret' {
                    $body.data.Add('closeLauncherOnCheckInSecret', @{ dirty = $true; value = [boolean]$CloseLauncherOnCheckInSecret })
                }
                'EnableDomainDownload' {
                    $body.data.Add('enableDomainDownload', @{ dirty = $true; value = [boolean]$EnableDomainDownload })
                }
                'EnableDomainUpload' {
                    $body.data.Add('enableDomainUpload', @{ dirty = $true; value = [boolean]$EnableDomainUpload })
                }
                'EnableLauncher' {
                    $body.data.Add('enableLauncher', @{ dirty = $true; value = [boolean]$EnableLauncher })
                }
                'EnableLauncherAutoUpdate' {
                    $body.data.Add('enableLauncherAutoUpdate', @{ dirty = $true; value = [boolean]$EnableLauncherAutoUpdate })
                }
                'EnableWebParsing' {
                    $body.data.Add('enableWebParsing', @{ dirty = $true; value = [boolean]$EnableWebParsing })
                }
                'LauncherDeploymentType' {
                    $body.data.Add('launcherDeploymentType', @{ dirty = $true; value = $LauncherDeploymentType })
                }
                'SendSecretUrlToLauncher' {
                    $body.data.Add('sendSecretUrlToLauncher', @{ dirty = $true; value = [boolean]$SendSecretUrlToLauncher })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher settings", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssLauncherSettings request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.LauncherSettings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.LauncherSettings]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
