class TssSession {
    [string]$SecretServer
    [string]$ApiVersion = 'api/v1'
    [string]$ApiUrl
    [string]$AccessToken
    [string]$RefreshToken
    [string]$TokenType
    hidden [datetime]$StartTime
    [int]$ExpiresIn
    hidden [datetime]$TimeOfDeath
    [int]$Take = [int]::MaxValue

    [boolean]IsValidSession() {
        if ([string]::IsNullOrEmpty($this.AccessToken) -and $this.StartTime -eq '0001-01-01 00:00:00') {
            return $false
        } else {
            return $true
        }
    }

    [boolean]IsValidToken() {
        if ($this.TokenType -like 'DefaultCredentials') {
            Write-Host 'Windows Integrated Auth in use'
            return $true
        } elseif ([string]::IsNullOrEmpty($this.AccessToken)) {
            Write-Host 'No valid token found for current TssSession object'
            return $false
        } elseif ([datetime]::Now -lt $this.TimeOfDeath -and ($this.TokenType -ne 'ExternalToken')) {
            return $true
        } elseif ([datetime]::Now -gt $this.TimeOfDeath -and ($this.TokenType -ne 'ExternalToken')) {
            Write-Host 'Token is not valid and has exceeded TimeOfDeath'
            return $false
        } elseif ($this.TokenType -eq 'ExternalToken') {
            Write-Warning 'Token was provided through external source so it cannot be validated'
            return $true
        } else {
            return $true
        }
    }

    [boolean]SessionExpire() {
        if ($this.TokenType -eq 'DefaultCredentials') {
            Write-Warning 'Using currently logged on user, SessionExpire is not possible'
            return $false
        }

        $url = $this.ApiUrl, 'oauth-expiration' -join '/'
        try {
            Invoke-TssRestApi -Uri $url -Method Post -PersonalAccessToken $this.AccessToken
            return $true
        } catch {
            return $false
        }
    }

    [boolean]SessionRefresh() {
        switch ($this.TokenType) {
            'ExternalToken' {
                Write-Warning 'Token was provided through external source, SessionRefresh is not supported'
                return $false
            }
            'DefaultCredentials' {
                Write-Host 'Using currently logged on user, SessionRefresh is not needed'
                return $true
            }
        }
        try {
            $url = $this.SecretServer + 'oauth2/token' -join '/'
            $body = @{
                refresh_token = $this.RefreshToken
                grant_type    = 'refresh_token'
            }
            $response = Invoke-TssRestApi -Uri $url -Method Post -Body $body -ErrorAction Stop

            $this.AccessToken = $response.access_token
            $this.RefreshToken = $response.refresh_token
            $this.ExpiresIn = $response.expires_in
            $this.TokenType = $response.token_type
            $this.StartTime = [datetime]::Now
            $this.TimeOfDeath = [datetime]::Now.Add([timespan]::FromSeconds($response.expires_in))
            return $true
        } catch {
            throw $_
        }
    }
}
