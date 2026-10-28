function New-TssDiscoverySourceScannerSetting {
    <#
    .SYNOPSIS
    Add a scanner to an Active Directory discovery source

    .DESCRIPTION
    Adds a scanner to an Active Directory discovery source and returns its scanner map ID.
    Returns the existing scanner map ID when the source already has the scanner.
    Despite its name, Secret Server reads -DiscoveryScanTypeId as a scanner ID (DiscoveryItemScannerId), not a scan type ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .PARAMETER DiscoveryScanTypeId
    ID of the scanner to add: the DiscoveryItemScannerId from Get-TssDiscoverySourceAvailableScanner, not its DiscoveryScanTypeId

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $scanner = Get-TssDiscoverySourceAvailableScanner -TssSession $session -Id 3 | Where-Object DiscoveryItemScannerName -eq 'Windows Local Accounts'
    New-TssDiscoverySourceScannerSetting -TssSession $session -Id 3 -DiscoveryScanTypeId $scanner.DiscoveryItemScannerId

    Add the Windows Local Accounts scanner to discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoverySourceScannerSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoverySourceScannerSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SourceScannerSetting')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DiscoverySourceId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [int]
        $DiscoveryScanTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $Id, 'scanner-settings' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoveryScanTypeId' {
                    $body.data.Add('discoveryScanTypeId', $DiscoveryScanTypeId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source scanner setting: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoverySourceScannerSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceScannerSetting](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceScannerSetting]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
