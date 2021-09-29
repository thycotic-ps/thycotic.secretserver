function Enable-TssUser {
    <#
    .SYNOPSIS
    Enable a Secret Server User Account

    .DESCRIPTION
    Enable a Secret Server User Account

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssUser -TssSession $session -Id 28

    Enable User 28

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Enable-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Enable-TssUser.ps1

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
                        Write-Warning "Issue enabling User [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse.enabled) {
                        Write-Verbose "User [$user] enabled"
                    } else {
                        Write-Warning "User [$user] has not been enabled"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}