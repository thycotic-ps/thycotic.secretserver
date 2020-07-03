function New-TssSession {
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [Parameter(ParameterSetName = 'New')]
        [Alias('Server')]
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [Parameter(ParameterSetName = 'New')]
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

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
        if ($newTssParams.Contains('SecretServer') -and $newTssParams.Contains('Credential')) {
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

        if ($response.access_token) {
            $TssSession.AuthToken = $response.access_token
            $TssSession.RefreshToken = $response.refresh_token
            $TssSession.RefreshCount = if ($postContent.grant_type -eq 'refresh_token') { $TssSession.RefreshCount - 1 } else { $RefreshLimit }
            $TssSession.ExpiresInSec = $response.expires_in
            $TssSession.StartTime = [datetime]::UtcNow
            $TssSession.TimeOfDeath = [datetime]::UtcNow.Add([timespan]::FromSeconds($response.expires_in))
            $TssSession.AutoReconnect = $AutoReconnect
        }
        if ($response.access_token -and $Raw) {
            return $response
        }
    }
}