function Set-TssConfigurationLoginPolicy {
    <#
    .SYNOPSIS
    Set the login policy configuration

    .DESCRIPTION
    Updates the login policy banner shown on the login page and returns the updated configuration.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Name:$false turns a setting off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnableLoginPolicy
    Show the login policy banner on the login page

    .PARAMETER ForceLoginPolicy
    Users must accept the login policy to log in

    .PARAMETER LoginPolicy
    Login policy text shown in the banner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationLoginPolicy -TssSession $session -EnableLoginPolicy -ForceLoginPolicy -LoginPolicy 'Authorized use only.'

    Show a login policy banner that users must accept

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationLoginPolicy -TssSession $session -EnableLoginPolicy:$false

    Stop showing the login policy banner

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationLoginPolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationLoginPolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EnableLoginPolicy,

        [switch]
        $ForceLoginPolicy,

        [string]
        $LoginPolicy
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'login-policy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EnableLoginPolicy' {
                    $body.data.Add('enableLoginPolicy', @{ dirty = $true; value = [boolean]$EnableLoginPolicy })
                }
                'ForceLoginPolicy' {
                    $body.data.Add('forceLoginPolicy', @{ dirty = $true; value = [boolean]$ForceLoginPolicy })
                }
                'LoginPolicy' {
                    $body.data.Add('loginPolicy', @{ dirty = $true; value = $LoginPolicy })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration login policy", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationLoginPolicy request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ConfigurationLoginPolicy]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
