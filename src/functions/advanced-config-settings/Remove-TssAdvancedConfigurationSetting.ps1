function Remove-TssAdvancedConfigurationSetting {
    <#
    .SYNOPSIS
    Remove an advanced configuration setting value

    .DESCRIPTION
    Removes the stored value of an advanced configuration setting, so the setting goes back to its default.
    Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Advanced configuration setting id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssAdvancedConfigurationSetting -TssSession $session -Id 12

    Remove the stored value of advanced configuration setting 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssAdvancedConfigurationSetting -TssSession $session -SearchText 'Timeout' | Remove-TssAdvancedConfigurationSetting -TssSession $session -WhatIf

    Show which timeout setting values would be removed, without removing them

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Remove-TssAdvancedConfigurationSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Remove-TssAdvancedConfigurationSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('AdvancedSettingId')]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'advanced-config-settings', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Advanced configuration setting: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssAdvancedConfigurationSetting request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Common.Delete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
