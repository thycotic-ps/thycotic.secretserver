function Set-TssConfigurationLocalUserPassword {
    <#
    .SYNOPSIS
    Set Local User Password configuration options

    .DESCRIPTION
    Set Local User Password configuration options

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationLocalUserPassword -TssSession $session -PasswordHistory -PasswordHistoryCount 50

    Enable Password History, keeping 50 passwords of history

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationLocalUserPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationLocalUserPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Enable Password History
        [switch]
        $PasswordHistory,

        # Number of passwords stored in history, defaults to All
        [int]
        $PasswordHistoryCount = [int]::MaxValue,

        # Allow users to reset forgotten passwords
        [switch]
        $ResetForgottenPassword,

        # Enable Local User password expiration
        [switch]
        $PasswordExpiration,

        # Expiration in days
        [int]
        $ExpirationDay,

        # Expiration in hours
        [ValidateRange(0,24)]
        [int]
        $ExpirationHour,

        # Expiration in minutes
        [ValidateRange(0,1440)]
        [int]
        $ExpirationMinute,

        # Enable minimum password age
        [switch]
        $MinimumPasswordAge,

        # Age in days
        [int]
        $AgeDay,

        # Age in hours
        [ValidateRange(0,24)]
        [int]
        $AgeHour,

        # Age in minutes
        [ValidateRange(0,1440)]
        [int]
        $AgeMinute,

        # Require numbers in a password
        [switch]
        $RequireNumber,

        # Require symbols in a password
        [switch]
        $RequireSymbol,

        # Require uppercase in a password
        [switch]
        $RequireUppercase,

        # Require lowercase in a password
        [switch]
        $RequireLowercase
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'local-user-passwords' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{ } }
            switch ($setParams.Keys) {
                'PasswordHistory' {
                    $enablePwdHistory = @{
                        dirty = $true
                        value = [boolean]$PasswordHistory
                    }
                    $setBody.data.Add('enablePasswordHistory',$enablePwdHistory)
                }
                'PasswordHistoryCount' {
                    if ($PasswordHistoryCount -eq [int]::MaxValue) {
                        $enableHistoryAll = @{
                            dirty = $true
                            value = $true
                        }
                        $setBody.data.Add('passwordHistoryItemsAll',$enableHistoryAll)
                    } else {
                        $enableHistoryItem = @{
                            dirty = $true
                            value = $PasswordHistoryCount
                        }
                        $setBody.data.Add('passwordHistoryItems',$enableHistoryItem)
                    }
                }
                'ResetForgottenPassword' {
                    $allowForgotten = @{
                        dirty = $true
                        value = [boolean]$ResetForgottenPassword
                    }
                    $setBody.data.Add('allowUsersToResetForgottenPasswords',$allowForgotten)
                }
                'PasswordExpiration' {
                    $enableExpiration = @{
                        dirty = $true
                        value = [boolean]$PasswordExpiration
                    }
                    $setBody.data.Add('enableLocalUserPasswordExpiration',$enableExpiration)
                }
                'ExpirationDay' {
                    $expireDay = @{
                        dirty = $true
                        value = $ExpirationDay
                    }
                    $setBody.data.Add('localUserPasswordExpirationDays',$expireDay)
                }
                'ExpirationHour' {
                    $expireHr = @{
                        dirty = $true
                        value = $ExpirationDay
                    }
                    $setBody.data.Add('localUserPasswordExpirationHours',$expireHr)
                }
                'ExpirationMinute' {
                    $expireMin = @{
                        dirty = $true
                        value = $Expirationminute
                    }
                    $setBody.data.Add('localUserPasswordExpirationMinutes',$expireMin)
                }
                'MinimumPasswordAge' {
                    $pwdAge = @{
                        dirty = $true
                        value = [boolean]$MinimumPasswordAge
                    }
                    $setBody.data.Add('enableMinimumPasswordAge',$pwdAge)
                }
                'AgeDay' {
                    $ageD = @{
                        dirty = $true
                        value = $AgeDay
                    }
                    $setBody.data.Add('minimumPasswordAgeDays',$ageD)
                }
                'AgeHour' {
                    $ageH = @{
                        dirty = $true
                        value = $AgeHour
                    }
                    $setBody.data.Add('minimumPasswordAgeHours',$ageH)
                }
                'AgeMinute' {
                    $ageM = @{
                        dirty = $true
                        value = $AgeMinute
                    }
                    $setBody.data.Add('minimumPasswordAgeMinutes',$ageM)
                }
                'RequireNumber' {
                    $requireNum = @{
                        dirty = $true
                        value = [boolean]$RequireNumber
                    }
                    $setBody.data.Add('passwordRequireNumbers',$requireNum)
                }
                'RequireSymbol' {
                    $requireSym = @{
                        dirty = $true
                        value = [boolean]$RequireSymbol
                    }
                    $setBody.data.Add('passwordRequireSymbols',$requireSym)
                }
                'RequireUppercase' {
                    $requireUpper = @{
                        dirty = $true
                        value = [boolean]$RequireUppercase
                    }
                    $setBody.data.Add('passwordRequireUppercase',$requireUpper)
                }
                'RequireLowercase' {
                    $requireLower = @{
                        dirty = $true
                        value = [boolean]$RequireLowercase
                    }
                    $setBody.data.Add('passwordRequireLowercase',$requireLower)
                }
            }

            $invokeParams.Body = $setBody | ConvertTo-Json
            if ($PSCmdlet.ShouldProcess("Local User Configuration", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting configuration"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose "Setting updated successfully"
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}