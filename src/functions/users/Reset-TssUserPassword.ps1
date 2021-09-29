function Reset-TssUserPassword {
    <#
    .SYNOPSIS
    Reset a User's password

    .DESCRIPTION
    Reset a User's password

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Reset-TssUserPassword -TssSession $session -Id 4

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Reset-TssUserPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Reset-TssUserPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        # New password for the user
        [Parameter(Mandatory)]
        [securestring]
        $Password
    )
    begin {
        $resetParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($resetParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $user, 'password-reset' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $resetBod = @{
                    data = @{
                        password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))
                        userId   = $user
                    }
                }
                $invokeParams.Body = $resetBod | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("User ID: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue reseting password for User [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                if ($restResponse.success) {
                    Write-Verbose "Passsword for User [$user] has been reset"
                } else {
                    Write-Warning "Password for User [$user] has not been reset"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}