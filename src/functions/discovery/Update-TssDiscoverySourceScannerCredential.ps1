function Update-TssDiscoverySourceScannerCredential {
    <#
    .SYNOPSIS
    Replace the credentials of a discovery source scanner

    .DESCRIPTION
    Replaces the credentials a scanner on a discovery source uses to log in to the items it scans.
    Each -SecretId and each -SecretSearchFilterId becomes one credential, secrets first, in the order given.
    Credentials not given are removed; -Clear removes them all.
    Secret Server rejects an empty list when the discovery source has no secret of its own, unless the scanner is a file load or manual input scanner.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DiscoverySourceId
    Discovery source ID

    .PARAMETER DiscoveryItemScannerId
    Scanner ID on the discovery source

    .PARAMETER SecretId
    IDs of the secrets to use as credentials

    .PARAMETER SecretSearchFilterId
    IDs of the secret search filters that find the secret to use as a credential (Search-TssDiscoverySecretSearchFilter)

    .PARAMETER Clear
    Remove every credential of the scanner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDiscoverySourceScannerCredential -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 9 -SecretId 31, 32

    Make scanner 9 of discovery source 3 log in with secret 31, then secret 32

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDiscoverySourceScannerCredential -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 9 -SecretSearchFilterId 4

    Make scanner 9 of discovery source 3 log in with the secret found by secret search filter 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDiscoverySourceScannerCredential -TssSession $session -DiscoverySourceId 3 -DiscoveryItemScannerId 14 -Clear

    Remove every credential of scanner 14 of discovery source 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Update-TssDiscoverySourceScannerCredential

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Update-TssDiscoverySourceScannerCredential.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'credential', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.OperationResult')]
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

        [Parameter(ParameterSetName = 'credential')]
        [int[]]
        $SecretId,

        [Parameter(ParameterSetName = 'credential')]
        [int[]]
        $SecretSearchFilterId,

        [Parameter(Mandatory, ParameterSetName = 'clear')]
        [switch]
        $Clear
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($PSCmdlet.ParameterSetName -eq 'credential' -and -not ($tssParams.ContainsKey('SecretId') -or $tssParams.ContainsKey('SecretSearchFilterId'))) {
                throw 'Specify -SecretId, -SecretSearchFilterId or -Clear'
            }
            $uri = $TssSession.ApiUrl, 'discovery', 'source', $DiscoverySourceId, 'scanners', $DiscoveryItemScannerId, 'credentials' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $credentials = @(
                foreach ($currentSecretId in $SecretId) {
                    @{ secretId = $currentSecretId }
                }
                foreach ($currentFilterId in $SecretSearchFilterId) {
                    @{ secretSearchFilterId = $currentFilterId }
                }
            )
            $body = @{ data = @{ credentials = $credentials } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery source $DiscoverySourceId scanner: $DiscoveryItemScannerId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDiscoverySourceScannerCredential request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
