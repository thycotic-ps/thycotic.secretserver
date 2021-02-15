function New-Session {
    <#
    .SYNOPSIS
    Create new session

    .DESCRIPTION
    Create a new TssSession for working with a Secret Server

    .EXAMPLE
    $cred = [PSCredential]::new('apiuser',(ConvertTo-SecureString -String "Fancy%$#Passwod" -AsPlainText -Force))
    New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential $cred

    A PSCredential is created for the apiuser account. The internal TssSession is updated upon successful authentication, and then output to the console.

    .EXAMPLE
    $token = .\tss.exe -kd c:\secretserver\module_testing\ -cd c:\secretserver\module_testing
    $tssSession = New-TssSession -SecretServer https://ssvault.com/SecretServer -AccessToken $token

    A token is requested via Client SDK (after proper init has been done)
    TssSession object is created with minimum properties required by the module.
    Note that this use case, SessionRefresh and SessionExpire are not supported

    .EXAMPLE
    New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser)

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

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/New-TssSession

    .OUTPUTS
    TssSession.
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('TssSession')]
    param(
        # Secret Server URL
        [Parameter(Mandatory,ParameterSetName = 'new', Position = 0)]
        [Parameter(Mandatory,ParameterSetName = 'sdk', Position = 0)]
        [Parameter(Mandatory,ParameterSetName = 'winauth', Position = 1)]
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [Parameter(Mandatory, ParameterSetName = 'new')]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specify Access Token
        [Parameter(Mandatory, ParameterSetName = 'sdk')]
        $AccessToken,

        # Utilize Windows Authentication (IWA)
        [Parameter(Mandatory, ParameterSetName = 'winauth')]
        [switch]
        $UseWindowsAuth
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
            $outputTssSession.ApiUrl = $outputTssSession.SecretServer + $outputTssSession.ApiVersion
        }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"

        if ($outputTssSession.SecretServer) {
            Write-Verbose "SecretServer host: $($outputTssSession.SecretServer)"
            if ($newTssParams.ContainsKey('Credential')) {
                $invokeParams.Uri = $outputTssSession.SecretServer + 'oauth2/token'

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
                    $restResponse = Invoke-TssRestApi @invokeParams
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
            if ($newTssParams.ContainsKey('UseWindowsAuth')) {
                if (-not $PSCmdlet.ShouldProcess($outputTssSession.SecretServer, "Setting SecretServer: [$($outputTssSession.SecretServer)] and TokenType: ['WinAuth']")) { return }
            }
            $outputTssSession.StartTime = [datetime]::Now
            return $outputTssSession
        } else {
            Write-Warning "SecretServer argument not found"
        }
    }
}
