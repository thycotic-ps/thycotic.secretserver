function Disable-User {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Disable-TssUser

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Disable-User.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
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
                    enabled = @{
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