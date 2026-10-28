function Get-TssDiscoveryScanner {
    <#
    .SYNOPSIS
    Get a Discovery scanner

    .DESCRIPTION
    Returns one or more Discovery scanners by id, including the base scanner, input and output scan templates, and the script or command set they run.
    An id with no matching Discovery scanner writes an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Scanner id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryScanner -TssSession $session -Id 12

    Get scanner 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDiscoveryScanner -TssSession $session -ScanTypeId 3 | Get-TssDiscoveryScanner -TssSession $session

    Get the detail of every active scanner that finds local accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.Scanner')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ItemScannerId', 'DiscoveryItemScannerId')]
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
                $uri = $TssSession.ApiUrl, 'discovery', 'scanners', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoveryScanner request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -eq 'null') {
                    $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Discovery scanner $currentId not found"), 'ScannerNotFound', 'ObjectNotFound', $currentId))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Discovery.Scanner](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.Scanner]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
