function Unlock-User {
    <#
    .SYNOPSIS
    Unlock a Secret Server User Account

    .DESCRIPTION
    Unlock a Secret Server User Account

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Unlock-TssUser -TssSession $session -Id 28

    Unlock User 28

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Unlock-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Unlock-User.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User Id
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $uri = $TssSession.ApiUrl, 'users', $user -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $userBody = @{
                    isLockedOut = @{
                        dirty = $true
                        value = $false
                    }
                }
                $invokeParams.Body = $userBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("SecretId: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $restResponse = . $InvokeApi @invokeParams
                    } catch {
                        Write-Warning "Issue unlocking User [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.isLockedOut -eq $false) {
                        Write-Verbose "User [$user] unlocked"
                    } else {
                        Write-Warning "User [$user] has not been unlocked"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}