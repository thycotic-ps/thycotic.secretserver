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
    New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser) -Raw

    A prompt to enter the password for the apiuser is given by PowerShell. Upon successful authentication the response from the oauth2/token endpoint is output to the console.

    .EXAMPLE
    $secretCred = [pscredential]::new('ssadmin',(ConvertTo-SecureString -String 'F@#R*(@#$SFSDF1234' -AsPlainText -Force)))
    $session = nts https://ssvault.com/SecretServer $secretCred

    Create a credential object
    Use the alias nts to create a session object

    .LINK
    https://thycotic.secretserver.github.io/commands/New-TssSession

    .OUTPUTS
    TssSession.
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('TssSession')]
    param(
        # Secret Server URL
        [Parameter(ParameterSetName = 'new',Mandatory)]
        [Parameter(ParameterSetName = 'sdk',
            Mandatory)]
        [Alias('Server')]
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [Parameter(ParameterSetName = 'new')]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specify Access Token
        # Bypasses requesting a token from Secret Server
        [Parameter(ParameterSetName = 'sdk')]
        $AccessToken,

        # Raw output from the endpoint will be returned.
        [Parameter(ParameterSetName = 'new')]
        [switch]
        $Raw
    )

    begin {
        $newTssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        if (-not $newTssParams['AccessToken']) {
            if ($newTssParams.ContainsKey('SecretServer')) {
                $uri = $SecretServer, "oauth2/token" -join '/'
            }

            $postContent = [Ordered]@{ }

            if ($newTssParams.ContainsKey('Credential')) {
                $postContent.username = $Credential.UserName
                $postContent.password = $Credential.GetNetworkCredential().Password
                $postContent.grant_type = 'password'
            }

            $invokeParams.Uri = $Uri
            $invokeParams.Body = $postContent
            $invokeParams.Method = 'POST'

            if (-not $PSCmdlet.ShouldProcess("POST $uri")) { return }
            try {
                $restResponse = Invoke-TssRestApi @invokeParams -Property @{SecretServer = $SecretServer }
            } catch {
                Write-Warning "Issue authenticating to [$SecretServer]"
                $err = $_.ErrorDetails.Message
                Write-Error $err
            }

            if ($newTssParams['Raw']) {
                return $restResponse
            }
            if ($restResponse) {
                $sessionObj = [TssSession]::new()
                $sessionObj.SecretServer = $restResponse.SecretServer
                $sessionObj.ApiUrl =
                if ( ($restResponse.SecretServer).PathAndQuery -eq '/') {
                    [string]$restResponse.SecretServer + $sessionObj.ApiVersion
                } elseif ( ($restResponse.SecretServer).PathAndQuery.Length -gt 1) {
                    [string]$restResponse.SecretServer, $sessionObj.ApiVersion -join '/'
                } elseif ( ($restResponse.SecretServer).Segments -contains 'api/') {
                    [string]$restResponse.SecretServer
                }
                $sessionObj.AccessToken = $restResponse.access_token
                $sessionObj.RefreshToken = $restResponse.refresh_token
                $sessionObj.ExpiresIn = $restResponse.expires_in
                $sessionObj.TokenType = $restResponse.token_type
                $sessionObj.StartTime = [datetime]::Now
                $sessionObj.TimeOfDeath = [datetime]::Now.Add([timespan]::FromSeconds($restResponse.expires_in))

                return $sessionObj
            }
        }
        if ($newTssParams['SecretServer'] -and $newTssParams['AccessToken']) {
            [TssSession]@{
                SecretServer  = $SecretServer
                AccessToken   = $AccessToken
                StartTime     = [datetime]::Now
                ExternalToken = $true
            }
        }
    }
}