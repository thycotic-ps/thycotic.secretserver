function Lock-TssUser {
    <#
    .SYNOPSIS
    Lock a Secret Server User Account

    .DESCRIPTION
    Lock a Secret Server User Account

    With -ReasonType the user is locked out through the lock-out endpoint, which records the reason and description with the lockout.

    .PARAMETER ReasonType
    Why the user is locked out: SuspiciousActivity, LoginAttemptsExceeded, Other or InvalidSecurityBlob

    .PARAMETER Description
    Free text stored with the lockout

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Lock-TssUser -TssSession $session -Id 28

    Lock User 28

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Lock-TssUser -TssSession $session -Id 28 -ReasonType SuspiciousActivity -Description 'Logins from an unknown network'

    Lock out User 28 and record the reason with the lockout

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Lock-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Lock-TssUser.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'user')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User Id
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'lockout')]
        [ValidateSet('SuspiciousActivity', 'LoginAttemptsExceeded', 'Other', 'InvalidSecurityBlob')]
        [string]
        $ReasonType,

        [Parameter(ParameterSetName = 'lockout')]
        [string]
        $Description
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                if ($PSCmdlet.ParameterSetName -eq 'lockout') {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'users', $user, 'lock-out' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'

                    $lockOutBody = @{ data = @{ reasonType = $ReasonType } }
                    if ($tssParams.ContainsKey('Description')) {
                        $lockOutBody.data.Add('description', $Description)
                    }
                    $invokeParams.Body = $lockOutBody | ConvertTo-Json -Depth 100
                    if ($PSCmdlet.ShouldProcess("User: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                        Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                        try {
                            $apiResponse = Invoke-TssApi @invokeParams
                            $restResponse = . $ProcessResponse $apiResponse
                        } catch {
                            Write-Warning "Issue locking out User [$user]"
                            $err = $_
                            . $ErrorHandling $err
                        }

                        if ($restResponse.success) {
                            Write-Verbose "User [$user] locked out"
                        } else {
                            Write-Warning "User [$user] has not been locked out"
                        }
                    }
                    continue
                }
                $uri = $TssSession.ApiUrl, 'users', $user -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $userBody = @{
                    isLockedOut = @{
                        dirty = $true
                        value = $true
                    }
                }
                $invokeParams.Body = $userBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("SecretId: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue locking User [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.isLockedOut) {
                        Write-Verbose "User [$user] locked out"
                    } else {
                        Write-Warning "User [$user] has not been locked out"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
