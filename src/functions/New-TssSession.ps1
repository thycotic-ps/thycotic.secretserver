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
    System.Management.Automation.PSCustomObject.
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(ParameterSetName = 'New')]
        [Parameter(ParameterSetName = 'tss')]
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

        # Utilize Refresh Token in TssSession to re-authenticate
        [Parameter(ParameterSetName = 'Refresh')]
        [switch]
        $UseRefreshToken,

        # Secret Server Web Services can utilize a refresh token.
        # Default is 3, provide configured value to allow AutoConnect.
        [Parameter(ParameterSetName = 'New')]
        [int]
        $RefreshLimit,

        # In conjunction with RefreshLimit will utilize the refresh token to re-authenticate up to the limit.
        [Parameter(ParameterSetName = 'New')]
        [switch]
        $AutoReconnect,

        # A module session variable is used to collect output.
        # This switch can be provided to bypass use of that variable.
        # Raw output from the endpoint will be returned.
        [Parameter(ParameterSetName = 'New')]
        [Parameter(ParameterSetName = 'Refresh')]
        [switch]
        $Raw
    )

    begin {
        $invokeParams = . $GetInvokeTssParams $PSBoundParameters
        $newTssParams = . $GetNewTssParams $PSBoundParameters
    }

    process {
        if ($newTssParams.Contains('SecretServer')) {
            $TssSession.SecretServerUrl = $SecretServer
        }

        . $TestTssSession -Session
        $uri = $TssSession.SecretServerUrl, "oauth2/token" -join '/'

        $postContent = [Ordered]@{ }

        if ($UseRefreshToken) {
            . $TestTssSession -Refresh
            $postContent.grant_type = 'refresh_token'
            $postContent.refresh_token = $TssSession.RefreshToken
        }

        if ($Credential) {
            $postContent.username = $Credential.UserName
            $postContent.password = $Credential.GetNetworkCredential().Password
            $postContent.grant_type = 'password'
        }

        $invokeParams.Uri = $Uri
        $invokeParams.Body = $postContent
        $invokeParams.Method = 'POST'

        if (-not $PSCmdlet.ShouldProcess("POST $uri")) { return }
        $response = Invoke-TssRestApi @invokeParams

        if ($response.access_token -and $Raw) {
            return $response
        } else {
            $TssSession.AccessToken = $response.access_token
            $TssSession.RefreshToken = $response.refresh_token
            $TssSession.RefreshCount = if ($postContent.grant_type -eq 'refresh_token') { $TssSession.RefreshCount - 1 } else { $RefreshLimit }
            $TssSession.ExpiresInSec = $response.expires_in
            $TssSession.StartTime = [datetime]::UtcNow
            $TssSession.TimeOfDeath = [datetime]::UtcNow.Add([timespan]::FromSeconds($response.expires_in))
            $TssSession.AutoReconnect = $AutoReconnect

            Get-TssSession
        }
    }
}