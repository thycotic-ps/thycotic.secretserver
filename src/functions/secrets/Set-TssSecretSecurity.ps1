function Set-TssSecretSecurity {
    <#
    .SYNOPSIS
    Set Secret general security options

    .DESCRIPTION
    Set Secret general security options

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretSecurity -TssSession $session -Id 42

    DOING something

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretSecurity

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretSecurity.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # DoubleLock to associate to the secret
        [int]
        $DoubleLockId,

        # Hide the launcher password from non-owners (Viewing Password Requires Edit in UI)
        [switch]
        $HideLauncherPassword,

        # Enable proxy on the Secret
        [switch]
        $ProxyEnabled,

        # Require comment to view the Secret
        [switch]
        $RequiresComment,

        # Enable Session Recording for the Secret
        [switch]
        $SessionRecordingEnabled,

        # Require Web Launcher to be incognito mode for the Secret
        [switch]
        $WebLauncherRequiresIncognitoMode
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'security-general' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $setBody = @{ data = @{ } }

                $whatIfProcessing = 0
                switch ($setParams.Keys) {
                    'DoubleLockId' {
                        if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "Setting DoubleLockID to $($DoubleLockId)")) {
                            $whatIfProcessing++
                        }
                        $setBody.data.doubleLockId = @{
                            dirty = $true
                            value = $DoubleLockId
                        }
                        $setBody.data.enableDoubleLock = @{
                            dirty = $true
                            value = $true
                        }
                    }
                    'HideLauncherPassword' {
                        if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "Setting [Viewing Password Requires Edit] to $HideLauncherPassword")) {
                            $whatIfProcessing++
                        }
                        $setBody.data.hideLauncherPassword = @{
                            dirty = $true
                            value = [boolean]$HideLauncherPassword
                        }
                    }
                    'ProxyEnabled' {
                        if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "Setting ProxyEnabled to $ProxyEnabled")) {
                            $whatIfProcessing++
                        }
                        $setBody.data.proxyEnabled = @{
                            dirty = $true
                            value = [boolean]$ProxyEnabled
                        }
                    }
                    'RequiresComment' {
                        if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "Setting RequiresComment to $RequiresComment")) {
                            $whatIfProcessing++
                        }
                        $setBody.data.requiresComment = @{
                            dirty = $true
                            value = [boolean]$RequiresComment
                        }
                    }
                    'SessionRecordingEnabled' {
                        if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "Setting SessionRecordingEnabled to $SessionRecordingEnabled")) {
                            $whatIfProcessing++
                        }
                        $setBody.data.sessionRecordingEnabled = @{
                            dirty = $true
                            value = [boolean]$SessionRecordingEnabled
                        }
                    }
                    'WebLauncherRequiresIncognitoMode' {
                        if (-not $PSCmdlet.ShouldProcess("Secret ID: $secret", "Setting WebLauncherRequiresIncognitoMode to $WebLauncherRequiresIncognitoMode")) {
                            $whatIfProcessing++
                        }
                        $setBody.data.webLauncherRequiresIncognitoMode = @{
                            dirty = $true
                            value = $WebLauncherRequiresIncognitoMode
                        }
                    }
                }

                $invokeParams.Body = $setBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("Secret ID: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting property on Secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse) {
                    if ($setParams.ContainsKey('DoubleLockId') -and $restResponse.doublelockId.value -eq $DoubleLockId) {
                        Write-Verbose "DoubleLock ID on Secret [$secret] set to $DoubleLockId"
                    }
                    if ($setParams.ContainsKey('HideLauncherPassword') -and $restResponse.hideLauncherPassword.value -eq $HideLauncherPassword) {
                        Write-Verbose "Viewing Password Requires Edit [HideLauncherPassword] on Secret [$secret] set to $HideLauncherPassword"
                    }
                    if ($setParams.ContainsKey('ProxyEnabled') -and $restResponse.proxyEnabled.value -eq $ProxyEnabled) {
                        Write-Verbose "Proxy on Secret [$secret] set to $ProxyEnabled"
                    }
                    if ($setParams.ContainsKey('RequiresComment') -and $restResponse.requiresComment.value -eq $RequiresComment) {
                        Write-Verbose "Require comment on Secret [$secret] set to $RequiresComment"
                    }
                    if ($setParams.ContainsKey('SessionRecordingEnabled') -and $restResponse.sessionRecordingEnabled.value -eq $SessionRecordingEnabled) {
                        Write-Verbose "Session Recording on Secret [$secret] set to $SessionRecordingEnabled"
                    }
                    if ($setParams.ContainsKey('WebLauncherRequiresIncognitoMode') -and $restResponse.webLauncherRequiresIncognitoMode.value -eq $WebLauncherRequiresIncognitoMode) {
                        Write-Verbose "Web Launcher requires Incognito Mode on Secret [$secret] set to $WebLauncherRequiresIncognitoMode"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}