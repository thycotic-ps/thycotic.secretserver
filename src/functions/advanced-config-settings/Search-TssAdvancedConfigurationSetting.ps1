function Search-TssAdvancedConfigurationSetting {
    <#
    .SYNOPSIS
    Search advanced configuration settings

    .DESCRIPTION
    Returns the advanced configuration settings with their setting id, name, type and current value.
    Advanced configuration settings are server-wide tuning options meant to be changed under Delinea support direction.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IsCloud
    Return only settings that apply to Secret Server Cloud

    .PARAMETER SearchText
    Text to match against the setting name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssAdvancedConfigurationSetting -TssSession $session

    List every advanced configuration setting

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssAdvancedConfigurationSetting -TssSession $session -SearchText 'Timeout'

    List the advanced configuration settings whose name contains Timeout

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/advanced-config-settings/Search-TssAdvancedConfigurationSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/advanced-config-settings/Search-TssAdvancedConfigurationSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.AdvancedConfigSettings.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IsCloud,

        [string]
        $SearchText
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
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'IsCloud' {
                    $queryParams += "filter.isCloud=$([boolean]$IsCloud)"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssAdvancedConfigurationSetting request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.AdvancedConfigSettings.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.AdvancedConfigSettings.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
