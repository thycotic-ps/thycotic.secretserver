function Get-TssDiagnosticAppSetting {
    <#
    .SYNOPSIS
    Get the Secret Server application settings

    .DESCRIPTION
    Gets the application settings (the appSettings section of web.config) as Key and Value pairs, the same list shown under Admin, Diagnostics.
    Uses the version 2 endpoint. Use -Legacy to read the version 1 endpoint, which returns the same settings as one object; each property becomes a Key and Value pair.
    Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Legacy
    Read the settings from the version 1 endpoint (GET api/v1/diagnostics/app-settings), for Secret Server versions without the version 2 endpoint

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiagnosticAppSetting -TssSession $session

    Get the application settings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiagnosticAppSetting -TssSession $session | Where-Object Key -Like 'webLauncher*'

    Get the web launcher settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssDiagnosticAppSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssDiagnosticAppSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Diagnostics.AppSetting[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'Legacy')]
        [switch]
        $Legacy
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'Legacy' {
                    $uri = $TssSession.ApiUrl, 'diagnostics', 'app-settings' -join '/'
                }
                default {
                    $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'diagnostics', 'app-settings' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDiagnosticAppSetting request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                if ($PSCmdlet.ParameterSetName -eq 'Legacy') {
                    $restResponse = foreach ($setting in $restResponse.PSObject.Properties) {
                        [pscustomobject]@{ key = $setting.Name; value = [string]$setting.Value }
                    }
                }
                [Thycotic.PowerShell.Diagnostics.AppSetting[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Diagnostics.AppSetting]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
