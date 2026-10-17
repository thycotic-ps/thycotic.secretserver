function Add-TssDiscoverySourceScanner {
    <#
    .SYNOPSIS
    Add a scanner to a discovery source

    .DESCRIPTION
    Adds a scanner to a discovery source and returns the scanner as attached to the source.
    A newly added scanner is not valid until its settings and credentials are set with Update-TssDiscoverySourceScannerSetting and Update-TssDiscoverySourceScannerCredential.
    Get-TssDiscoverySourceAvailableScanner lists the scanners that can be added.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery source ID

    .PARAMETER DiscoveryItemScannerId
    ID of the scanner to add, from Get-TssDiscoverySourceAvailableScanner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssDiscoverySourceScanner -TssSession $session -Id 3 -DiscoveryItemScannerId 12

    Add scanner 12 to discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Add-TssDiscoverySourceScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Add-TssDiscoverySourceScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.SourceScanner')]
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
        $DiscoveryItemScannerId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $Id, 'scanners' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DiscoveryItemScannerId' {
                    $body.data.Add('discoveryItemScannerId', $DiscoveryItemScannerId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source scanner: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Add-TssDiscoverySourceScanner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.SourceScanner](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.SourceScanner]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
