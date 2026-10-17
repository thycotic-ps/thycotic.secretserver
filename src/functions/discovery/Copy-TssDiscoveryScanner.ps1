function Copy-TssDiscoveryScanner {
    <#
    .SYNOPSIS
    Copy a Discovery scanner

    .DESCRIPTION
    Duplicates an existing Discovery scanner under a new name and returns the new scanner.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ItemScannerId
    Id of the scanner to copy

    .PARAMETER NewItemScannerName
    Name for the new scanner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Copy-TssDiscoveryScanner -TssSession $session -ItemScannerId 12 -NewItemScannerName 'Windows local accounts (custom)'

    Copy scanner 12 to a new scanner named Windows local accounts (custom)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanner -TssSession $session -DiscoveryItemScannerId 12 | Copy-TssDiscoveryScanner -TssSession $session -NewItemScannerName 'Windows local accounts (copy)'

    Copy the scanner returned by Search-TssDiscoveryScanner

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Copy-TssDiscoveryScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Copy-TssDiscoveryScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.Scanner')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DiscoveryItemScannerId')]
        [int]
        $ItemScannerId,

        [Parameter(Mandatory)]
        [string]
        $NewItemScannerName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners', 'duplicate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ItemScannerId' {
                    $body.data.Add('itemScannerId', $ItemScannerId)
                }
                'NewItemScannerName' {
                    $body.data.Add('newItemScannerName', $NewItemScannerName)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery scanner", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Copy-TssDiscoveryScanner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.Scanner](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.Scanner]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
