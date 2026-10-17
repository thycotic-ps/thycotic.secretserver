function Update-TssMfaProfile {
    <#
    .SYNOPSIS
    Update the MFA authentication profile in use

    .DESCRIPTION
    Make a Delinea Platform authentication profile the one used for multifactor authentication on secrets. Returns every profile, with IsCurrent on the one now in use.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Id of the authentication profile to use

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMfaProfile -TssSession $session | Where-Object Name -EQ 'Default MFA' | Update-TssMfaProfile -TssSession $session

    Use the Default MFA authentication profile

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Update-TssMfaProfile

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Update-TssMfaProfile.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud connected to the Delinea Platform only: other instances answer this endpoint with Access denied.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.MfaProfile[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('AuthProfileId')]
        [guid]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'mfa', 'set-auth-profile' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ authProfileId = $Id.ToString() }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("MFA profile: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                $restResponse = $null
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssMfaProfile request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.authProfiles) {
                    [Thycotic.PowerShell.Configuration.MfaProfile[]](. $FilterTssResponse $restResponse.authProfiles ([Thycotic.PowerShell.Configuration.MfaProfile]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
