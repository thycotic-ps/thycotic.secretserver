class TssSession {
    [string]$SecretServer
    [string]$ApiVersion = "api/v1"
    [string]$AccessToken
    [string]$RefreshToken
    [string]$TokenType
    hidden [datetime]$StartTime
    [int]$ExpiresIn
    hidden [datetime]$TimeOfDeath
    [int]$Take = [int]::MaxValue

    [boolean]IsValidSession() {
        if ([string]::IsNullOrEmpty($this.AccessToken) -and [string]::IsNullOrEmpty($this.RefreshToken) -and $this.StartTime -eq '0001-01-01 00:00:00') {
            return $false
        } else {
            return $true
        }
    }

    [boolean]IsValidToken() {
        if ([string]::IsNullOrEmpty($this.AccessToken)) {
            Write-Host 'No valid token found for current TssSession object'
            return $false
        } elseif ([datetime]::Now -lt $this.TimeOfDeath) {
            return $true
        } elseif ([datetime]::Now -gt $this.TimeOfDeath) {
            Write-Host 'Token is not valid and has exceeded TimeOfDeath'
            return $false
        } else {
            return $true
        }
    }

    [boolean]SessionExpire() {
        $url = $this.SecretServer, $this.ApiVersion, 'oauth-expiration' -join '/'
        try {
            Invoke-TssRestApi -Uri $url -Method Post -PersonalAccessToken $this.AccessToken
            return $true
        } catch {
            return $false
        }
    }

    [boolean]SessionRefresh() {
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
