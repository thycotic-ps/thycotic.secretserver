class TssSession {
    [string]$SecretServer
    [string]$ApiVersion = 'api/v1'
    [string]$WindowsAuth = 'winauthwebservices'
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
        } elseif ($this.TokenType -eq 'WindowsAuth') {
            return $true
        } else {
            return $true
        }
    }

    [boolean]IsValidToken() {
        if ([string]::IsNullOrEmpty($this.AccessToken)) {
            Write-Warning 'No valid token found for current TssSession object'
            return $false
        } elseif ([datetime]::Now -lt $this.TimeOfDeath -and ($this.TokenType -ne 'ExternalToken')) {
            return $true
        } elseif ([datetime]::Now -gt $this.TimeOfDeath -and ($this.TokenType -ne 'ExternalToken')) {
            Write-Warning 'Token is not valid and has exceeded TimeOfDeath'
            return $false
        } elseif ($this.TokenType -eq 'ExternalToken') {
            Write-Warning 'Token was provided through external source, unable to validate'
            return $true
        } elseif ($this.TokenType -eq 'WindowsAuth') {
            Write-Warning 'Windows Authentication being used, no validation required'
            return $true
        } else {
            return $true
        }
    }

    [boolean]SessionExpire() {
        $url = $this.ApiUrl, 'oauth-expiration' -join '/'
        try {
            if ($this.TokenType -ne 'WindowsAuth') {
                Invoke-TssRestApi -Uri $url -Method Post -PersonalAccessToken $this.AccessToken
                return $true
            } else {
                Write-Warning "Windows Authentication being used, SessionExpire is not supported"
                return $false
            }
        } catch {
            return $false
        }
    }

    [boolean]SessionRefresh() {
        if ($this.TokenType -eq 'ExternalToken') {
            Write-Warning 'Token was provided through external source, SessionRefresh is not supported'
            return $false
        }
        if ($this.TokenType -eq 'WindowsAuth') {
            Write-Warning 'Windows Authentication being used, SessionRefresh is not supported'
            return $false
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