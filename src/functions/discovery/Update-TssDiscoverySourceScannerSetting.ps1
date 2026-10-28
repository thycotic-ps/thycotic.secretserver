function Update-TssDiscoverySourceScannerSetting {
    <#
    .SYNOPSIS
    Replace the settings of a discovery source scanner

    .DESCRIPTION
    Replaces the settings of a scanner on a discovery source.
    Settings not given return to their default value, so pass every setting you want to keep.
    The setting names are the Name values in the ScannerItems of Get-TssDiscoverySourceScanner.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source ID

    .PARAMETER DiscoveryItemScannerId
    Scanner ID on the discovery source

    .PARAMETER Setting
    Setting names and values, for example @{ Ports = '22,2222'; DoAuthentication = 'False' }. Each value is sent as a string

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDiscoverySourceScannerSetting -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 9 -Setting @{ Ports = '22,2222'; DoAuthentication = 'False' }

    Scan ports 22 and 2222 without logging in to the machines found by scanner 9 of discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceScannerSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceScannerSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SourceScannerSettingResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DiscoverySourceId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DiscoveryItemScannerId,

        [Parameter(Mandatory)]
        [hashtable]
        $Setting
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $DiscoverySourceId, 'scanners', $DiscoveryItemScannerId, 'settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $settings = @(foreach ($settingName in $Setting.Keys) {
                    @{ settingName = [string]$settingName; settingValue = [string]$Setting[$settingName] }
                })
            $body = @{ data = @{ settings = $settings } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source $DiscoverySourceId scanner: $DiscoveryItemScannerId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDiscoverySourceScannerSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceScannerSettingResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceScannerSettingResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
