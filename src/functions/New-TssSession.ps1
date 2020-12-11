function New-TssSession {
    <#
    .SYNOPSIS
    Create new session

    .DESCRIPTION
    Create a new TssSession for working with a Secret Server

    .PARAMETER SecretServer
    Secret Server URL

    .PARAMETER Credential
    Secret Server account to be used for authentication

    .PARAMETER UseRefreshToken
    Use the refresh token for reauthenticating
    (to-do item)

    .PARAMETER RefreshLimit
    Use to specify the limit the refresh token can be used
    (to-do item)

    .PARAMETER AutoReconnect
    Use to have automatically reauthenticate if session timeout is hit
    (to-do item)

    .PARAMETER Raw
    Output raw response from the oauth2/token endpoint
    Internal TssSession object **is not** utilized

    .EXAMPLE
    PS C:\> $cred = [PSCredential]::new('apiuser',(ConvertTo-SecureString -String "Fancy%$#Passwod" -AsPlainText -Force))
    PS C:\> New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential $cred

    A PSCredential is created for the apiuser account. The internal TssSession is updated upon successful authentication, and then output to the console.

    .EXAMPLE
    PS C:\> New-TssSession -SecretServer https://ssvault.com/SecretServer -Credential (Get-Credential apiuser) -Raw

    A prompt to ener the password for the apiuser is given by PowerShell. Upon successful authentication the response from the oauth2/token endpoint is output to the console.

    .OUTPUTS
    TssSession.
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(ParameterSetName = 'New', Mandatory)]
        [Parameter(ParameterSetName = 'tss', Mandatory)]
        [Alias('Server')]
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [Parameter(ParameterSetName = 'New')]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specify Access Token
        [Parameter(ParameterSetName = 'tss')]
        $AccessToken,

        # A module session variable is used to collect output.
        # This switch can be provided to bypass use of that variable.
        # Raw output from the endpoint will be returned.
        [Parameter(ParameterSetName = 'New')]
        [switch]
        $Raw
    )

    begin {
        $invokeParams = . $GetInvokeTssParams $PSBoundParameters
        $newTssParams = . $GetNewTssParams $PSBoundParameters

        $TssSession = [TssSession]::new()
    }

    process {
        if ($newTssParams.Contains('SecretServer')) {
            $TssSession.SecretServerUrl = $SecretServer
        }

        # . $TestTssSession -Session
        if (-not $TssSession.IsValidSession()) {
            $uri = $TssSession.SecretServerUrl, "oauth2/token" -join '/'
        }

        $postContent = [Ordered]@{ }

        if ($newTssParams.Contains('Credential')) {
            $postContent.username = $Credential.UserName
            $postContent.password = $Credential.GetNetworkCredential().Password
            $postContent.grant_type = 'password'
        }

        $invokeParams.Uri = $Uri
        $invokeParams.Body = $postContent
        $invokeParams.Method = 'POST'

        if (-not $PSCmdlet.ShouldProcess("POST $uri")) { return }
        try {
            $response = Invoke-TssRestApi @invokeParams -ErrorAction Stop -ErrorVariable err
        } catch {
            throw $err
        }

        if ($response.access_token -and $Raw) {
            return $response
        } else {
            $TssSession.AccessToken = $response.access_token
            $TssSession.RefreshToken = $response.refresh_token
            $TssSession.ExpiresIn = $response.expires_in
            $TssSession.StartTime = [datetime]::Now
            $TssSession.TimeOfDeath = [datetime]::Now.Add([timespan]::FromSeconds($response.expires_in))
        }

        if ($TssSession.IsValidSession()) {
            return $TssSession
        } else {
            throw "Invalid session"
        }
    }
}