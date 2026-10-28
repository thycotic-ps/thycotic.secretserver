function New-TssDiscoveryScanner {
    <#
    .SYNOPSIS
    Create a Discovery scanner

    .DESCRIPTION
    Creates a Discovery scanner from a base scanner, with its input and output scan templates and, for PowerShell or SSH scanners, the script or command set it runs. Returns the created scanner.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER BaseScannerId
    Base scanner id

    .PARAMETER CommandSetId
    Command set id, for SSH scanners

    .PARAMETER ConcurrencyId
    Globally unique id for the scanner. The server sets one when omitted

    .PARAMETER InputScanItemTemplateId
    Input scan template id

    .PARAMETER IsActive
    Create the scanner active. Without it the scanner is created inactive

    .PARAMETER ItemScannerDescription
    Scanner description

    .PARAMETER ItemScannerName
    Scanner name

    .PARAMETER OutputScanItemTemplateId
    Output scan template id

    .PARAMETER ScanTypeId
    Scan type id: 1 find host ranges, 2 find machines, 3 find local accounts, 4 find dependencies

    .PARAMETER ScriptArguments
    Arguments passed to the PowerShell script

    .PARAMETER ScriptId
    PowerShell script id, for PowerShell scanners

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssDiscoveryScanner -TssSession $session -ItemScannerName 'Linux local accounts (custom)' -ScanTypeId 3 -BaseScannerId 5 -InputScanItemTemplateId 2 -OutputScanItemTemplateId 6 -CommandSetId 4 -IsActive

    Create an active SSH scanner that finds local accounts with command set 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryScanner.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.Scanner')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [int]
        $BaseScannerId,

        [int]
        $CommandSetId,

        [string]
        $ConcurrencyId,

        [Parameter(Mandatory)]
        [int]
        $InputScanItemTemplateId,

        [switch]
        $IsActive,

        [string]
        $ItemScannerDescription,

        [Parameter(Mandatory)]
        [string]
        $ItemScannerName,

        [Parameter(Mandatory)]
        [int]
        $OutputScanItemTemplateId,

        [Parameter(Mandatory)]
        [int]
        $ScanTypeId,

        [string]
        $ScriptArguments,

        [int]
        $ScriptId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'BaseScannerId' {
                    $body.data.Add('baseScannerId', $BaseScannerId)
                }
                'CommandSetId' {
                    $body.data.Add('commandSetId', $CommandSetId)
                }
                'ConcurrencyId' {
                    $body.data.Add('concurrencyId', $ConcurrencyId)
                }
                'InputScanItemTemplateId' {
                    $body.data.Add('inputScanItemTemplateId', $InputScanItemTemplateId)
                }
                'IsActive' {
                    $body.data.Add('isActive', [boolean]$IsActive)
                }
                'ItemScannerDescription' {
                    $body.data.Add('itemScannerDescription', $ItemScannerDescription)
                }
                'ItemScannerName' {
                    $body.data.Add('itemScannerName', $ItemScannerName)
                }
                'OutputScanItemTemplateId' {
                    $body.data.Add('outputScanItemTemplateId', $OutputScanItemTemplateId)
                }
                'ScanTypeId' {
                    $body.data.Add('scanTypeId', $ScanTypeId)
                }
                'ScriptArguments' {
                    $body.data.Add('scriptArguments', $ScriptArguments)
                }
                'ScriptId' {
                    $body.data.Add('scriptId', $ScriptId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery scanner", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoveryScanner request'
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
