function New-Session {
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
    $session = tssnts https://ssvault.com/SecretServer $secretCred

    Create a credential object
    Use the alias nts to create a session object

    .EXAMPLE
    $session = tssnts https://ssvault.com/SecretServer -UseWindowsAuth

    Create a session object utilizing Windows Integrated Authentication (IWA)
    Use the alias nts to create a session object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://vault.secretservercloud.com -UseSdkClient -ConfigPath c:\thycotic

    Create a session object utilizing SDK Client configuration, assumes Initialize-TssSdkClient was run with config path of C:\thycotic
    Token request performed via SDK Client meaning that token is good for life of the configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSession

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/New-Session.ps1

    .OUTPUTS
    TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('TssSession')]
    param(
        # Secret Server URL
        [Parameter(Mandatory,ParameterSetName = 'new', Position = 0)]
        [Parameter(Mandatory,ParameterSetName = 'sdk', Position = 0)]
        [Parameter(Mandatory,ParameterSetName = 'winauth', Position = 0)]
        [Parameter(Mandatory,ParameterSetName = 'clientSdk')]
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [Parameter(Mandatory,ParameterSetName = 'new', Position = 1)]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specify Access Token
        [Parameter(Mandatory,ParameterSetName = 'sdk')]
        $AccessToken,

        # Utilize Windows Authentication (IWA)
        [Parameter(Mandatory,ParameterSetName = 'winauth')]
        [switch]
        $UseWindowsAuth,

        # Utilize SDK Client
        [Parameter(Mandatory,ParameterSetName = 'clientSdk')]
        [switch]
        $UseSdkClient,

        # Config path for the key/config files
        [Parameter(ParameterSetName = 'clientSdk',Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $ConfigPath
    )
    begin {
        $newTssParams = $PSBoundParameters
        $invokeParams = @{ }

        $outputTssSession = [TssSession]::new()

        if ($SecretServer -match "(?:\/api\/v1)|(?:\/oauth2\/token)") {
            throw "Invalid argument on parameter SecretServer. Please ensure [/api/v1] or [/oauth2/token] are not provided"
            return
        } else {
            $outputTssSession.SecretServer = $SecretServer
        }
        if ($newTssParams.ContainsKey('UseWindowsAuth')) {
            $outputTssSession.ApiUrl = $outputTssSession.SecretServer.TrimEnd('/'), $outputTssSession.WindowsAuth, $outputTssSession.ApiVersion -join '/'
            $outputTssSession.TokenType = 'WindowsAuth'
        } else {
            $outputTssSession.ApiUrl = $outputTssSession.SecretServer.TrimEnd('/'), $outputTssSession.ApiVersion -join '/'
        }

        $tssExe = [IO.Path]::Combine([string]$PSModuleRoot, 'bin', 'tss.exe')
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"

        if ($outputTssSession.SecretServer) {
            Write-Verbose "SecretServer host: $($outputTssSession.SecretServer)"
            if ($newTssParams.ContainsKey('Credential')) {
                $invokeParams.Uri = $outputTssSession.SecretServer.TrimEnd('/'), 'oauth2', 'token' -join '/'

                $oauth2Body = [Ordered]@{ }
                if ($newTssParams.ContainsKey('Credential')) {
                    $oauth2Body.username = $Credential.UserName
                    $oauth2Body.password = $Credential.GetNetworkCredential().Password
                    $oauth2Body.grant_type = 'password'
                }

                $invokeParams.Body = $oauth2Body
                $invokeParams.Method = 'POST'

                if (-not $PSCmdlet.ShouldProcess($outputTssSession.SecretServer, "Requesting OAuth2 token from $($outputTssSession.SecretServer) with URI of [$($invokeParams.Uri)]")) { return }
                Write-Verbose "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue authenticating to [$SecretServer]"
                    $err = $_.ErrorDetails.Message
                    if ($err.Length -gt 0) {
                        throw $err
                    } elseif ($_ -like '*<html*') {
                        $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Response was HTML, Request Failed."),"ResultWasHTML", "NotSpecified", $invokeParams.Uri))
                    } else {
                        throw $_.Exception
                    }
                }

                if ($restResponse) {
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
                        $sdkEndpoint = $tssStatusOutput.Trim("Connected to endpoint ")
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
                        Write-Warning "Issue obtaining token via SDK Client (tss) config"
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
            try {
                $uri = $outputTssSession.ApiUrl, 'version' -join '/'
                $versionResponse = . $InvokeApi -Uri $uri -Method GET -PersonalAccessToken $outputTssSession.AccessToken

                $outputTssSession.SecretServerVersion = $versionResponse.model.version
            } catch {
                Write-Warning "Issue reading version of [$SecretServer], this may be due to Hide Secret Server Version Numbers being disabled. Version support is limited in the module and may affect functionality of some functions."
            }
            return $outputTssSession
        } else {
            Write-Warning "SecretServer argument not found"
        }
    }
}
