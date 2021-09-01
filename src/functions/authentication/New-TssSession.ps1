function New-TssSession {
    <#
    .SYNOPSIS
    Create new session

    .DESCRIPTION
    Create a new TssSession for working with a Secret Server

    .EXAMPLE
    $cred = [PSCredential]::new('apiuser',(ConvertTo-SecureString -String "Fancy%$#Passwod" -AsPlainText -Force))
    $session = New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential $cred

    A PSCredential is created for the apiuser account. The internal TssSession is updated upon successful authentication, and then output to the console.

    .EXAMPLE
    $token = .\tss.exe -kd c:\secretserver\module_testing\ -cd c:\secretserver\module_testing
    $session = New-TssSession -SecretServer https://ssvault.com/SecretServer -AccessToken $token

    A token is requested via Client SDK (after proper init has been done)
    TssSession object is created with minimum properties required by the module.
    Note that this use case, SessionRefresh and SessionExpire are not supported

    .EXAMPLE
    $session = New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser)

    A prompt to enter the password for the apiuser is given by PowerShell. Upon successful authentication the response from the oauth2/token endpoint is output to the console.

    .EXAMPLE
    $secretCred = [pscredential]::new('ssadmin',(ConvertTo-SecureString -String 'F@#R*(@#$SFSDF1234' -AsPlainText -Force)))
    $session = nts https://ssvault.com/SecretServer $secretCred

    Create a credential object
    Use the alias nts to create a session object

    .EXAMPLE
    $session = nts https://ssvault.com/SecretServer -UseWindowsAuth

    Create a session object utilizing Windows Integrated Authentication (IWA)
    Use the alias nts to create a session object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -UseSdkClient -ConfigPath c:\thycotic

    Create a session object utilizing SDK Client configuration, assumes Initialize-TssSdkClient was run with config path of C:\thycotic
    Token request performed via SDK Client meaning that token is good for life of the configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -Credential $cred -OtpCode 256380
    Show-TssCurrentUser -TssSession $session

    Create a session object using OAuth2 credential and 2FA/OTP code. Then output the current user to verify toke is for the specific user credential.

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
        # Secret Server URL
        [Parameter(Mandatory, ParameterSetName = 'new', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'sdk', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'winauth', Position = 0)]
        [Parameter(Mandatory, ParameterSetName = 'clientSdk')]
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [Parameter(Mandatory, ParameterSetName = 'new', Position = 1)]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Provide 2FA code
        [Parameter(ParameterSetName = 'new', Position = 2)]
        [int]
        $OtpCode,

        # Specify Access Token
        [Parameter(Mandatory, ParameterSetName = 'sdk')]
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
        $ConfigPath
    )
    begin {
        $newTssParams = $PSBoundParameters
        $invokeParams = @{ }

        $outputTssSession = [Thycotic.PowerShell.Authentication.Session]::new()
        $tssExe = [IO.Path]::Combine($clientSdkPath, 'tss.exe')
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
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

        if ($outputTssSession.SecretServer) {
            if ($newTssParams.ContainsKey('Credential')) {
                $newTokenParams = @{}
                $newTokenParams.Uri = $outputTssSession.SecretServer.TrimEnd('/'), 'oauth2', 'token' -join '/'


                Write-Verbose "Uri configured for OAuth2 request: $($newTokenParams.Uri)"
                if ($newTssParams.ContainsKey('OtpCode')) {
                    Write-Verbose "OtpCode provided"
                    $newTokenParams.OtpCode = $OtpCode
                }

                $newTokenParams.Username = $Credential.Username
                $newTokenParams.Password = $Credential.Password

                if (-not $PSCmdlet.ShouldProcess($outputTssSession.SecretServer, "Requesting OAuth2 token from $($outputTssSession.SecretServer) with URI of [$($newTokenParams.Uri)]")) { return }
                Write-Verbose "Performing the operation POST $($newTokenParams.Uri)"
                try {
                    $apiResponse = New-TssApiToken @newTokenParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue authenticating to [$SecretServer]"
                    $err = $_.ErrorDetails.Message
                    if ($err.Length -gt 0) {
                        throw $err
                    } elseif ($_ -like '*<html*') {
                        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new('Response was HTML, Request Failed.'), 'ResultWasHTML', 'NotSpecified', $invokeParams.Uri))
                    } else {
                        throw $_.Exception
                    }
                }

                if ($restResponse) {
                    Write-Verbose "Adding values to TssSession object"
                    $outputTssSession.AccessToken = $restResponse.access_token
                    $outputTssSession.RefreshToken = $restResponse.refresh_token
                    $outputTssSession.ExpiresIn = $restResponse.expires_in
                    $outputTssSession.TokenType = $restResponse.token_type
                    $outputTssSession.TimeOfDeath = [datetime]::Now.Add([timespan]::FromSeconds($restResponse.expires_in))
                }
            }
            if ($newTssParams.ContainsKey('AccessToken')) {
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
            $outputTssSession.StartTime = [datetime]::Now
            Write-Verbose "Setting start time for session: $($outputTssSession.StartTime)"
            try {
                Write-Verbose "Attempting to retrieve Secret Server host version"
                $versionResponse = Get-TssVersion -TssSession $outputTssSession
                $outputTssSession.SecretServerVersion = $versionResponse.Version
                if ($outputTssSession.SecretServerVersion) {
                    Write-Verbose "Version info received successfully: $($outputTssSession.SecretServerVersion)"
                }
            } catch {
                Write-Warning "Issue reading version of [$SecretServer], this may be due to Hide Secret Server Version Numbers being disabled. Version support is limited in the module and may affect functionality of some functions."
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
