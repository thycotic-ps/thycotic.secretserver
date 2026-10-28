function Search-TssMfaProfile {
    <#
    .SYNOPSIS
    Search the MFA authentication profiles

    .DESCRIPTION
    Get the Delinea Platform authentication profiles available for multifactor authentication on secrets. IsCurrent marks the profile in use.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssMfaProfile -TssSession $session | Where-Object IsCurrent

    Show the MFA authentication profile in use

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssMfaProfile

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssMfaProfile.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud connected to the Delinea Platform only: other instances answer this endpoint with Access denied.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.MfaProfile[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'mfa', 'get-auth-profiles' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssMfaProfile request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.authProfiles) {
                [Thycotic.PowerShell.Configuration.MfaProfile[]](. $FilterTssResponse $restResponse.authProfiles ([Thycotic.PowerShell.Configuration.MfaProfile]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
