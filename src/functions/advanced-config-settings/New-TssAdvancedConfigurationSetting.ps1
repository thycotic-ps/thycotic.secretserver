function New-TssAdvancedConfigurationSetting {
    <#
    .SYNOPSIS
    Create an advanced configuration setting value

    .DESCRIPTION
    Creates a value for an advanced configuration setting, identified by its setting id.
    Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction. Use Search-TssAdvancedConfigurationSetting to find setting ids and current values.
    Secret Server returns no setting from this request, so nothing is output; read the stored value back with Search-TssAdvancedConfigurationSetting. Listing the settings stores a value for every setting that has none, and this request changes nothing (and reports no error) for a setting that already has a value: change an existing value with Update-TssAdvancedConfigurationSetting.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AdvancedSettingId
    Advanced configuration setting id

    .PARAMETER Value
    Value to store for the setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssAdvancedConfigurationSetting -TssSession $session -AdvancedSettingId 12 -Value '30'

    Store the value 30 for advanced configuration setting 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/New-TssAdvancedConfigurationSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/New-TssAdvancedConfigurationSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $AdvancedSettingId,

        [Parameter(Mandatory)]
        [string]
        $Value
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'advanced-config-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'AdvancedSettingId' {
                    $body.Add('advancedSettingId', $AdvancedSettingId)
                }
                'Value' {
                    $body.Add('value', $Value)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Advanced configuration setting", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $null = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssAdvancedConfigurationSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
