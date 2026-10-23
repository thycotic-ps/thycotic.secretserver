function Update-TssAdvancedConfigurationSetting {
    <#
    .SYNOPSIS
    Update an advanced configuration setting value

    .DESCRIPTION
    Replaces the stored value of an advanced configuration setting, identified by its setting id, and returns the updated setting.
    Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.
    Advanced configuration settings are only to be updated by Delinea Support: modifying them will have a major impact on Secret Server.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AdvancedSettingId
    Advanced configuration setting id

    .PARAMETER Value
    New value for the setting

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssAdvancedConfigurationSetting -TssSession $session -AdvancedSettingId 12 -Value '60'

    Change the value of advanced configuration setting 12 to 60

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Update-TssAdvancedConfigurationSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Update-TssAdvancedConfigurationSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.AdvancedConfigSettings.Setting')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $AdvancedSettingId,

        [Parameter(Mandatory)]
        [string]
        $Value,

        [switch]
        $Force
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
            $invokeParams.Method = 'PUT'
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
            if (Confirm-TssDangerousOperation $PSCmdlet SupportOnlySetting "Advanced configuration setting" "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n" -Force:$Force) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssAdvancedConfigurationSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.AdvancedConfigSettings.Setting](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.AdvancedConfigSettings.Setting]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
