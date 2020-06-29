function New-TssSession {
    [cmdletbinding(SupportsShouldProcess)]
    param(
        [uri]
        $SecretServer,

        # Specify a Secret Server user account.
        [PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Utilize Refresh Token in TssSession to re-authenticate
        [switch]
        $UseRefreshToken,

        # Secret Server Web Services can utilize a refresh token.
        # Default is 3, provide configured value to allow AutoConnect.
        [int]
        $RefreshLimit,

        # In conjunction with RefreshLimit will utilize the refresh token to re-authenticate up to the limit.
        [switch]
        $AutoReconnect,

        # A module session variable is used to collect output.
        # This switch can be provided to bypass use of that variable.
        # Raw output from the endpoint will be returned.
        [switch]
        $Raw
    )
    dynamicParam { . $GetInvokeTssParams -DynamicParameter }

    begin {
        $invokeParams = . $GetInvokeTssParams $PSBoundParameters
        if ($SecretServer) {
            $TssSession.SecretServerHost = "$SecretServer".TrimEnd("/")
        }
    }

    process {
        if (-not $SecretServer -and (-not $TssSession.SecretServerHost)) {
            Write-Warning "No Secret Server host provided or found in TssSession"
        }

        $uri = $TssSession.SecretServerHost, "oauth2/token" -join '/'

        $postContent = [Ordered]@{ }

        if ($UseRefreshToken) {
            $postContent.grant_type = 'refresh_token'
            if (. $TestTssSession -Refresh) {
                $postContent.refresh_token = $TssSession.RefreshToken
            } else {
                Write-Warning "Current session state does not support use of refresh token. Try command with -Verbose or review Get-TssSession."
                return
            }
        } else {
            if ($Credential) {
                $postContent.username = $Credential.UserName
                $postContent.password = $Credential.GetNetworkCredential().Password
                $postContent.grant_type = 'password'
            } else {
                Write-Warning "No Credential provided."
                return
            }
        }

        $invokeParams.Uri = $Uri
        $invokeParams.Body = $postContent
        $invokeParams.Method = 'POST'

        if (-not $PSCmdlet.ShouldProcess("POST $uri with $($invokeParams.body)")) { return }
        $response = Invoke-TssRestApi @invokeParams

        if ($response.access_token) {
            $TssSession.AuthToken = $response.access_token
            $TssSession.RefreshToken = $response.refresh_token
            $TssSession.RefreshCount = if ($postContent.grant_type -eq 'refresh_token') { $TssSession.RefreshCount - 1 } else { $RefreshLimit }
            $TssSession.ExpiresInSec = $response.expires_in
            $TssSession.StartTime = [datetime]::UtcNow
            $TssSession.TimeOfDeath = [datetime]::UtcNow.Add([timespan]::FromSeconds($response.expires_in))
        }
        if ($response.access_token -and $Raw) {
            return $response
        }
    }
}