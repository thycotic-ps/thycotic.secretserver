function New-TssSession {
    <#
    .SYNOPSIS
    Create new session

    .DESCRIPTION
    Create a new TssSession for working with a Secret Server

    With -PlatformUrl the session authenticates to the Delinea Platform instead: -Credential takes a Platform service user (client credentials grant, scope xpmheadless) or -AccessToken takes a Platform access token you already have.
    The Platform vault broker supplies the Secret Server vault URL (the active vault with -VaultId, else the global default, else the default, else the first active vault) and the Platform token is sent to that vault.
    The vault URL must use https and its host must be a Secret Server Cloud host, the Platform host itself, or a host listed in -AllowedVaultHost; nothing is sent to any other host.

    .PARAMETER SecretServer
    Secret Server URL.
    With -PlatformUrl, the vault URL to use instead of the vault broker answer (with -Credential the vault broker is not called).

    .PARAMETER Credential
    Specify a Secret Server user account.
    With -PlatformUrl, a Delinea Platform service user: the user name is the client id and the password is the client secret.

    .PARAMETER AccessToken
    Specify Access Token.
    With -PlatformUrl, a Delinea Platform access token you already have; it is validated with the Platform vault broker.

    .PARAMETER PlatformUrl
    URL of the Delinea Platform tenant, for example https://mytenant.delinea.app. Only https is accepted.

    .PARAMETER VaultId
    Vault id to use from the Platform vault broker. The vault must be active.

    .PARAMETER AllowedVaultHost
    Additional vault hosts to trust, as host or host:port (a host alone covers port 443 only).
    Needed when the vault is not a Secret Server Cloud host, for example an on-premises Secret Server connected to the Platform.

    .PARAMETER AutoRefresh
    Keep the Platform service user client secret on the session (as a SecureString) so SessionRefresh() can request a new Platform access token.
    Without it nothing is kept and SessionRefresh() returns False for a Platform session.

    .EXAMPLE
    $cred = [PSCredential]::new('apiuser',(ConvertTo-SecureString -String 'Fancy%$#Pa33w0rd' -AsPlainText -Force))
    $session = New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential $cred

    A PSCredential is created for the apiuser account. The internal TssSession is updated upon successful authentication, and then output to the console.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser)

    A prompt to enter the password for the apiuser is given by PowerShell. Upon successful authentication the response from the oauth2/token endpoint is output to the console.

    .EXAMPLE
    $tssSdkParams = @{
        SecretServer = 'https://ssvault.com/SecretServer'
        RuleName = 'tss_module'
        ConfigPath = 'c:\thycotic'
        Force = $true
    }
    Initialize-TssSdk @tssSdkParams
    $session = New-TssSession -SecretServer https://ssvault.com/SecretServer -UseSdkClient -ConfigPath c:\thycotic

    Use packaged Client SDK and initialize for vault using Onboarding Client rule and configuration path.
    Create a new TssSession object that uses the initialized Client SDK under the configuration path "c:\thycotic"

    .EXAMPLE
    $session = nts https://ssvault.com/SecretServer -UseWindowsAuth

    Create a session object utilizing Windows Integrated Authentication (IWA)
    Use the alias nts to create a session object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -Credential $cred -OtpCode '012345'
    Show-TssCurrentUser -TssSession $session

    Create a session object using OAuth2 credential and 2FA/OTP code. Then output the current user to verify toke is for the specific user credential. Quote the OtpCode to preserve any leading zeros.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -Credential $cred
    $secrets = Search-TssSecret -TssSession $session
    foreach ($s in $secrets) {
        if ($session.CheckTokenTtl(3)) { $session.SessionRefresh() }
        # code to execute against each Secret
    }
    $session.SessionExpire()

    Creates a session object and pulls a list of Secrets to process.
    Uses method CheckTokenTtl() on the TssSession object if the TimeOfDeath is within 3 minutes of expiring will run the SessionRefresh() method to request a new access token.
    Once processing is complete, run the SessionExpire() method to expire the access token.

    .EXAMPLE
    $serviceUser = Get-Credential platform-automation
    $session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser
    Search-TssFolder -TssSession $session

    Authenticates the Delinea Platform service user platform-automation with the client credentials grant, finds the default Secret Server vault through the Platform vault broker, and searches folders in that vault.

    .EXAMPLE
    $session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser -AutoRefresh
    if ($session.CheckTokenTtl(5)) { $session.SessionRefresh() }

    Creates a Platform session that keeps the service user client secret (as a SecureString) so SessionRefresh() can request a new Platform access token when fewer than 5 minutes remain.

    .EXAMPLE
    $session = New-TssSession -PlatformUrl https://mytenant.delinea.app -AccessToken $platformToken -VaultId 5b2e8f1c-0d3a-4b7e-9c61-2f4a8d9e0b13

    Uses a Delinea Platform access token obtained elsewhere, validates it with the Platform vault broker, and connects to the active vault with that id.

    .EXAMPLE
    $session = New-TssSession -PlatformUrl https://mytenant.delinea.app -Credential $serviceUser -SecretServer https://vault.example.com/SecretServer -AllowedVaultHost vault.example.com

    Sends the Platform token to an on-premises Secret Server connected to the Platform. The host is not a Secret Server Cloud host, so it is trusted only because -AllowedVaultHost lists it.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/authentication/New-TssSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/authentication/New-TssSession.ps1

    .OUTPUTS
    TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Authentication.Session')]
    param(
        [Parameter(Mandatory, ParameterSetName = 'new', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'sdk', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'winauth', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'clientSdk')]
        [Parameter(ParameterSetName = 'platform')]
        [Parameter(ParameterSetName = 'platformToken')]
        [uri]
        $SecretServer,

        [Parameter(Mandatory, ParameterSetName = 'new', Position = 1)]
        [Parameter(Mandatory, ParameterSetName = 'platform')]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Provide 2FA code
        [Parameter(ParameterSetName = 'new', Position = 2)]
        [string]
        $OtpCode,

        [Parameter(Mandatory, ParameterSetName = 'sdk')]
        [Parameter(Mandatory, ParameterSetName = 'platformToken')]
        $AccessToken,

        # Utilize Windows Authentication (IWA)
        [Parameter(Mandatory, ParameterSetName = 'winauth')]
        [switch]
        $UseWindowsAuth,

        # Utilize SDK Client
        [Parameter(Mandatory, ParameterSetName = 'clientSdk')]
        [switch]
        $UseSdkClient,

        # Config path for the key/config files
        [Parameter(ParameterSetName = 'clientSdk', Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $ConfigPath,

        [Parameter(Mandatory, ParameterSetName = 'platform')]
        [Parameter(Mandatory, ParameterSetName = 'platformToken')]
        [uri]
        $PlatformUrl,

        [Parameter(ParameterSetName = 'platform')]
        [Parameter(ParameterSetName = 'platformToken')]
        [string]
        $VaultId,

        [Parameter(ParameterSetName = 'platform')]
        [Parameter(ParameterSetName = 'platformToken')]
        [string[]]
        $AllowedVaultHost,

        [Parameter(ParameterSetName = 'platform')]
        [switch]
        $AutoRefresh,

        # Skip SSL/TLS certificate validation (use for self-signed certificates)
        [switch]
        $SkipCertificateCheck
    )
    begin {
        $newTssParams = $PSBoundParameters
        $invokeParams = @{ }

        $outputTssSession = [Thycotic.PowerShell.Authentication.Session]::new()
        $tssExe = [IO.Path]::Combine($clientSdkPath, 'tss.exe')
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($PSCmdlet.ParameterSetName -in 'platform', 'platformToken') {
            if (-not $PlatformUrl.IsAbsoluteUri) {
                $PlatformUrl = [uri]"https://$($PlatformUrl.OriginalString)"
            }
            if ($PlatformUrl.Scheme -ne 'https' -or $PlatformUrl.UserInfo) {
                throw 'Invalid argument on parameter PlatformUrl. Provide the https URL of the Delinea Platform tenant, for example https://mytenant.delinea.app'
            }
            if ($newTssParams.ContainsKey('VaultId') -and $newTssParams.ContainsKey('SecretServer')) {
                throw 'Provide -VaultId or -SecretServer, not both'
            }
            $platformBase = 'https://' + $PlatformUrl.Authority
            $outputTssSession.AuthProvider = 'Platform'
            $outputTssSession.PlatformUrl = $platformBase
            $outputTssSession.IsPlatformToken = $true
            $outputTssSession.TokenType = 'Platform'
            if ($newTssParams.ContainsKey('SkipCertificateCheck')) {
                $outputTssSession.SkipCertificateCheck = $true
            }
            if (-not $PSCmdlet.ShouldProcess($platformBase, "Authenticating to Delinea Platform [$platformBase] and resolving the Secret Server vault")) { return }

            if ($PSCmdlet.ParameterSetName -eq 'platform') {
                $tokenUri = $platformBase, 'identity', 'api', 'oauth2', 'token', 'xpmplatform' -join '/'
                Write-Verbose "Performing the operation POST $tokenUri"
                $apiResponse = [Thycotic.PowerShell.Authentication.Request]::PlatformToken($platformBase, $Credential.UserName, $Credential.Password, $outputTssSession.SkipCertificateCheck, 0)
                if (-not $apiResponse.IsSuccessful) {
                    $statusCode = [int]$apiResponse.StatusCode
                    if ($statusCode -eq 0) {
                        throw "Unable to reach Delinea Platform [$platformBase]: $($apiResponse.ErrorMessage)"
                    }
                    $platformMessage = $apiResponse.StatusDescription
                    if ($apiResponse.Content -match '"error_description"\s*:\s*"([^"]+)"') {
                        $platformMessage = $Matches[1]
                    } elseif ($apiResponse.Content -match '"error"\s*:\s*"([^"]+)"') {
                        $platformMessage = $Matches[1]
                    }
                    if ($apiResponse.Content -match 'Login failed|invalid client|client not allowed') {
                        throw "Delinea Platform rejected the client credentials for [$($Credential.UserName)] (HTTP $($statusCode): $platformMessage). -PlatformUrl with -Credential needs a Platform service user: the user name is the client id and the password is the client secret. Human and federated Platform users cannot use the client credentials grant."
                    }
                    throw "Delinea Platform token request for [$($Credential.UserName)] failed with HTTP $($statusCode): $platformMessage"
                }
                $tokenResponse = $apiResponse.Content | ConvertFrom-Json
                if (-not $tokenResponse.access_token) {
                    throw "Delinea Platform [$platformBase] did not return an access token"
                }
                $outputTssSession.AccessToken = $tokenResponse.access_token
                $outputTssSession.ExpiresIn = $tokenResponse.expires_in
                $outputTssSession.TimeOfDeath = [datetime]::Now.Add([timespan]::FromSeconds($tokenResponse.expires_in))
                if ($AutoRefresh) {
                    $outputTssSession.EnablePlatformAutoRefresh($Credential)
                }
            } else {
                $outputTssSession.AccessToken = $AccessToken
                $tokenParts = ([string]$AccessToken).Split('.')
                if ($tokenParts.Count -eq 3) {
                    $tokenPayload = $tokenParts[1].Replace('-', '+').Replace('_', '/')
                    $tokenPayload = $tokenPayload.PadRight($tokenPayload.Length + (4 - $tokenPayload.Length % 4) % 4, '=')
                    try {
                        $tokenClaims = [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($tokenPayload)) | ConvertFrom-Json
                        if ($tokenClaims.exp) {
                            $outputTssSession.TimeOfDeath = [DateTimeOffset]::FromUnixTimeSeconds([long]$tokenClaims.exp).LocalDateTime
                            $outputTssSession.ExpiresIn = [int]($outputTssSession.TimeOfDeath - [datetime]::Now).TotalSeconds
                        }
                    } catch {
                        Write-Verbose 'Access token expiry is not readable, TimeOfDeath not set'
                    }
                }
            }

            if ($PSCmdlet.ParameterSetName -eq 'platformToken' -or -not $newTssParams.ContainsKey('SecretServer')) {
                $vaultError = $null
                $vaults = @(Get-TssPlatformVault -TssSession $outputTssSession -ErrorAction SilentlyContinue -ErrorVariable vaultError -WarningAction SilentlyContinue)
                if ($vaultError) {
                    if ($tssLastResponse.StatusCode -eq 0) {
                        throw "Unable to reach the Delinea Platform vault broker [$platformBase]: no HTTP response ($($tssLastResponse.ResponseStatus))"
                    }
                    $brokerMessage = $vaultError[0].Exception.Message
                    if (-not $brokerMessage) {
                        $brokerMessage = 'the access token was not accepted'
                    }
                    throw "Delinea Platform vault broker request to [$platformBase] failed with HTTP $($tssLastResponse.StatusCode): $brokerMessage"
                }
            }
            if ($newTssParams.ContainsKey('SecretServer')) {
                $vaultUrl = $SecretServer.OriginalString.TrimEnd('/')
            } else {
                $activeVaults = @($vaults | Where-Object IsActive)
                if ($newTssParams.ContainsKey('VaultId')) {
                    $vault = $activeVaults | Where-Object VaultId -EQ $VaultId | Select-Object -First 1
                    if (-not $vault) {
                        throw "No active vault with id '$VaultId' was returned by the vault broker."
                    }
                } else {
                    $vault = $activeVaults | Sort-Object -Stable -Property @{ Expression = { -not $_.IsGlobalDefault } }, @{ Expression = { -not $_.IsDefault } } | Select-Object -First 1
                    if (-not $vault) {
                        throw 'No active vault was returned by the vault broker.'
                    }
                }
                $outputTssSession.VaultId = $vault.VaultId
                $outputTssSession.VaultType = $vault.Type
                $vaultUrl = $vault.Url
            }
            & $PlatformVaultTrust -VaultUrl $vaultUrl -PlatformUrl $platformBase -AllowedVaultHost $AllowedVaultHost
            Write-Verbose "Secret Server vault resolved to [$vaultUrl]"
            $SecretServer = $vaultUrl
        }
        if ($SecretServer -match '(?:\/api\/v1)|(?:\/oauth2\/token)') {
            throw 'Invalid argument on parameter SecretServer. Please ensure [/api/v1] or [/oauth2/token] are not provided'
            return
        } else {
            $outputTssSession.SecretServer = $SecretServer
        }
        if ($newTssParams.ContainsKey('UseWindowsAuth')) {
            Write-Verbose "UseWindowsAuth provided, setting URL segment to use $($outputTssSession.WindowsAuth)"
            $outputTssSession.ApiUrl = $outputTssSession.SecretServer.TrimEnd('/'), $outputTssSession.WindowsAuth, $outputTssSession.ApiVersion -join '/'
            $outputTssSession.TokenType = 'WindowsAuth'
        } else {
            $outputTssSession.ApiUrl = $outputTssSession.SecretServer.TrimEnd('/'), $outputTssSession.ApiVersion -join '/'
        }

        if ($newTssParams.ContainsKey('SkipCertificateCheck')) {
            $outputTssSession.SkipCertificateCheck = $true
        }

        if ($outputTssSession.SecretServer) {
            if ($PSCmdlet.ParameterSetName -eq 'new') {
                $newTokenParams = @{}
                $newTokenParams.Uri = $outputTssSession.SecretServer.TrimEnd('/'), 'oauth2', 'token' -join '/'

                Write-Verbose "Uri configured for OAuth2 request: $($newTokenParams.Uri)"
                if ($newTssParams.ContainsKey('OtpCode')) {
                    Write-Verbose "OtpCode provided"
                    $newTokenParams.OtpCode = $OtpCode
                }

                $newTokenParams.Username = $Credential.Username
                $newTokenParams.Password = $Credential.GetNetworkCredential().Password
                if ($newTssParams.ContainsKey('SkipCertificateCheck')) {
                    $newTokenParams.SkipCertificateCheck = $true
                }

                if (-not $PSCmdlet.ShouldProcess($outputTssSession.SecretServer, "Requesting OAuth2 token from $($outputTssSession.SecretServer) with URI of [$($newTokenParams.Uri)]")) { return }
                Write-Verbose "Performing the operation POST $($newTokenParams.Uri)"
                try {
                    $apiResponse = New-TssApiToken @newTokenParams
                    $restResponse = . $ProcessResponse $apiResponse -ErrorAction Stop
                } catch {
                    Write-Warning "Issue authenticating to [$SecretServer]"
                    $err = $_.ErrorDetails.Message
                    if ($err.Length -gt 0) {
                        throw $err
                    } elseif ($_ -like '*<html*') {
                        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new('Response was HTML, Request Failed.'), 'ResultWasHTML', 'NotSpecified', $invokeParams.Uri))
                    } elseif ([string]::IsNullOrEmpty($_.Exception.Message)) {
                        $hint = if ($newTssParams.ContainsKey('SkipCertificateCheck')) {
                            "Connection to [$SecretServer] failed with no error detail. Check network connectivity and that the URL is correct."
                        } else {
                            "Connection to [$SecretServer] failed with no error detail. If the server uses a self-signed or untrusted TLS certificate, add -SkipCertificateCheck to New-TssSession."
                        }
                        throw [Exception]::new($hint)
                    } else {
                        throw $_.Exception
                    }
                }

                if ($restResponse) {
                    Write-Verbose "Configuring TssSession object"
                    $outputTssSession.AccessToken = $restResponse.access_token
                    $outputTssSession.RefreshToken = $restResponse.refresh_token
                    $outputTssSession.ExpiresIn = $restResponse.expires_in
                    $outputTssSession.TokenType = $restResponse.token_type
                    $outputTssSession.TimeOfDeath = [datetime]::Now.Add([timespan]::FromSeconds($restResponse.expires_in))
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'sdk') {
                if (-not $PSCmdlet.ShouldProcess($outputTssSession.SecretServer, "Setting SecretServer: [$($outputTssSession.SecretServer)] and TokenType: ['ExternalToken']")) { return }
                $outputTssSession.AccessToken = $AccessToken
                $outputTssSession.TokenType = 'ExternalToken'
            }
            if ($newTssParams.ContainsKey('UseSdkClient')) {
                Write-Verbose "Processing SDK Client"
                if (Test-Path $tssExe) {
                    try {
                        $tssStatusArgs = "status --key-directory $ConfigPath --config-directory $ConfigPath"
                        $tssStatusInfo = New-Object System.Diagnostics.ProcessStartInfo
                        $tssStatusInfo.FileName = $tssExe
                        $tssStatusInfo.Arguments = $tssStatusArgs
                        $tssStatusInfo.RedirectStandardError = $true
                        $tssStatusInfo.RedirectStandardOutput = $true
                        $tssStatusInfo.UseShellExecute = $false
                        $tssProcess = New-Object System.Diagnostics.Process
                        $tssProcess.StartInfo = $tssStatusInfo
                        $tssProcess.Start() | Out-Null
                        $tssProcess.WaitForExit()
                        $tssStatusOutput = $tssProcess.StandardOutput.ReadToEnd()
                        $tssStatusOutput += $tssProcess.StandardError.ReadToEnd()

                        Write-Verbose "SDK Client raw response: $tssStatusOutput"
                        $sdkEndpoint = $tssStatusOutput.Trim('Connected to endpoint ')
                    } catch {
                        Write-Warning "Issue capturing status of current SDK Client (tss) config for [$SecretServer]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ([uri]$sdkEndpoint -ne $outputTssSession.SecretServer) {
                        Write-Warning "Provided SecretServer host [$SecretServer] does not match SDK Client configuration of [$sdkEndpoint]"
                        return
                    }

                    try {
                        $tssTokenArgs = "token --key-directory $ConfigPath --config-directory $ConfigPath"
                        $tssTokenInfo = New-Object System.Diagnostics.ProcessStartInfo
                        $tssTokenInfo.FileName = $tssExe
                        $tssTokenInfo.Arguments = $tssTokenArgs
                        $tssTokenInfo.RedirectStandardError = $true
                        $tssTokenInfo.RedirectStandardOutput = $true
                        $tssTokenInfo.UseShellExecute = $false
                        $tssProcess = New-Object System.Diagnostics.Process
                        $tssProcess.StartInfo = $tssTokenInfo
                        $tssProcess.Start() | Out-Null
                        $tssProcess.WaitForExit()
                        $tssTokenOutput = $tssProcess.StandardOutput.ReadToEnd()
                        $tssTokenOutput += $tssProcess.StandardError.ReadToEnd()

                        $sdkToken = $tssTokenOutput
                        Write-Verbose "SDK Client token value: $sdkToken"
                    } catch {
                        Write-Warning 'Issue obtaining token via SDK Client (tss) config'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($sdkToken.Length -gt 0) {
                        $outputTssSession.AccessToken = $sdkToken.TrimEnd()
                        $outputTssSession.TokenType = 'SdkClient'
                    }
                } else {
                    Write-Warning 'Issue finding SDK Client (tss) in module, please ensure bin files still exists'
                    return
                }
            }
            if (-not $outputTssSession.AccessToken -and $outputTssSession.TokenType -ne 'WindowsAuth') {
                Write-Warning "Unable to retrieve an Access Token"
                return
            }
            $outputTssSession.StartTime = [datetime]::Now
            Write-Verbose "Setting start time for session: $($outputTssSession.StartTime)"
            if ($outputTssSession.IsPlatformToken) {
                $versionError = $null
                $versionResponse = Get-TssVersion -TssSession $outputTssSession -ErrorAction SilentlyContinue -ErrorVariable versionError -WarningAction SilentlyContinue
                if ($versionError) {
                    if ($tssLastResponse.StatusCode -eq 0) {
                        throw "Unable to reach Secret Server vault [$($outputTssSession.SecretServer)]: no HTTP response ($($tssLastResponse.ResponseStatus))"
                    }
                    $vaultMessage = $versionError[0].Exception.Message
                    if ($vaultMessage -match '"message"\s*:\s*"([^"]+)"') {
                        $vaultMessage = $Matches[1]
                    }
                    throw "Secret Server vault [$($outputTssSession.SecretServer)] did not accept the Delinea Platform token (HTTP $($tssLastResponse.StatusCode)): $vaultMessage"
                }
                $outputTssSession.SecretServerVersion = $versionResponse.Version
            }
            if ($ignoreVersion -or ((Test-Path variable:tss_ignoreversioncheck) -and $tss_ignoreversioncheck)) {
                Write-Verbose "tss_ignoreversioncheck set to true, module will not perform Secret Server version check"
            } elseif (-not $outputTssSession.SecretServerVersion) {
                Write-Verbose "Attempting to retrieve Secret Server host version"
                $versionResponse = Get-TssVersion -TssSession $outputTssSession -ErrorAction SilentlyContinue
                $outputTssSession.SecretServerVersion = $versionResponse.Version
                if ($outputTssSession.SecretServerVersion) {
                    Write-Verbose "Version info received successfully: $($outputTssSession.SecretServerVersion)"
                } else {
                    Write-Warning "Issue reading version of [$SecretServer], this may be due to Hide Secret Server Version Numbers being disabled. Version support is limited in the module and may affect functionality of some functions."
                }
            }
            Write-Verbose "SecretServer host: $($outputTssSession.SecretServer)"
            Write-Verbose "ApiUrl: $($outputTssSession.ApiUrl)"
            Write-Verbose "Outputing final object"
            return $outputTssSession
        } else {
            Write-Warning 'SecretServer argument not found'
        }
    }
}
