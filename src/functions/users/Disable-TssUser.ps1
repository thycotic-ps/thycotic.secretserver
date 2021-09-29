function Disable-TssUser {
    <#
    .SYNOPSIS
    Disable a Secret Server User Account

    .DESCRIPTION
    Disable a Secret Server User Account

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssUser -TssSession $session -Id 28

    Disable User 28

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Disable-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Disable-TssUser.ps1

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
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $uri = $TssSession.ApiUrl, 'users', $user -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $userBody = @{
                    enabled = @{
                        dirty = $true
                        value = $false
                    }
                }
                $invokeParams.Body = $userBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("SecretId: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue disabling User [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.enabled -eq $false) {
                        Write-Verbose "User [$user] has been disabled"
                    } else {
                        Write-Warning "User [$user] has not been disabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}