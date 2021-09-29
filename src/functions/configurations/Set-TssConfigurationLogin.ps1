function Set-TssConfigurationLogin {
    <#
    .SYNOPSIS
    Set Login Configuration

    .DESCRIPTION
    Set Login Configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationLogin -TssSession session -AutoComplete:$false

    Disable Allow Auto Complete option

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationLogin

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationLogin.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Allow Auto Complete
        [switch]
        $AutoComplete,

        # Allow Remember Me
        [switch]
        $RememberMe,

        # Cache AD Credentials for when Engines are offline
        [switch]
        $CacheADCredential,

        # Default Login Domain
        [string]
        $DefaultDomain,

        # Enable Domain Selector (ShowDropdown, DomainLabel, HideDomain)
        [Thycotic.PowerShell.Enums.DomainSelectorOption]
        $DomainSelector,

        # Enable Login Failure CAPTCHA
        [switch]
        $FailureCaptcha,

        # Max Login Failures before CAPTCHA
        [int]
        $MaxFailureBeforeCaptcha,

        # Maximum concurrent logins per user
        [int]
        $MaxConcurrentLogin,

        # Maximum Login Failures
        [int]
        $MaxLoginFailure,

        # Remember Me timeout, in minutes (0 = Unlimited)
        [int]
        $RememberMeTimeout,

        # User Lockout Time (Minutes)
        [int]
        $LockoutTime
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'login' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{ } }
            switch ($setParams.Keys) {
                'AutoComplete' {
                    $autoC = @{
                        dirty = $true
                        value = [boolean]$AutoComplete
                    }
                    $setBody.data.Add('allowAutoComplete',$autoC)
                }
                'RememberMe' {
                    $remMe = @{
                        dirty = $true
                        value = [boolean]$RememberMe
                    }
                    $setBody.data.Add('allowRememberMe',$remMe)
                }
                'CacheADCredential' {
                    $cacheAd = @{
                        dirty = $true
                        value = [boolean]$CacheADCredential
                    }
                    $setBody.data.Add('cacheADCredentials',$cacheAd)
                }
                'DefaultDomain' {
                    $defDomain = @{
                        dirty = $true
                        value = $DefaultDomain
                    }
                    $setBody.data.Add('defaultLoginDomain',$defDomain)
                }
                'DomainSelector' {
                    $domainS = @{
                        dirty = $true
                        value = [int]$DomainSelector
                    }
                    $setBody.data.Add('enableDomainSelector',$domainS)
                }
                'FailureCaptcha' {
                    $enableCaptcha = @{
                        dirty = $true
                        value = [boolean]$FailureCaptcha
                    }
                    $setBody.data.Add('enableLoginFailureCAPTCHA',$enableCaptcha)
                }
                'MaxFailureBeforeCaptcha' {
                    $maxBeforeCaptcha = @{
                        dirty = $true
                        value = $MaxFailureBeforeCaptcha
                    }
                    $setBody.data.Add('maxLoginFailuresBeforeCAPTCHA',$maxBeforeCaptcha)
                }
                'MaxConcurrentLogin' {
                    $maxSessions = @{
                        dirty = $true
                        value = $MaxConcurrentLogin
                    }
                    $setBody.data.Add('maxConcurrentLoginsPerUser',$maxSessions)
                }
                'MaxLoginFailure' {
                    $maxFailure = @{
                        dirty = $true
                        value = $MaxLoginFailure
                    }
                    $setBody.data.Add('maximumLoginFailures',$maxFailure)
                }
                'RememberMeTimeout' {
                    $remMeTimeout = @{
                        dirty = $true
                        value = $RememberMeTimeout
                    }
                    $setBody.data.Add('rememberMeTimeOutMinutes',$remMeTimeout)
                }
                'LockoutTime' {
                    $lockTime = @{
                        dirty = $true
                        value = $LockoutTime
                    }
                    $setBody.data.Add('userLockoutTimeMinutes',$lockTime)
                }
            }
            $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("Login Configuration", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting Login Configuration"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose 'Setting updated successfully'
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}