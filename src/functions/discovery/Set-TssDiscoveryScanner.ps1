function Set-TssDiscoveryScanner {
    <#
    .SYNOPSIS
    Update a discovery scanner

    .DESCRIPTION
    Updates a discovery scanner.
    Only the parameters given are changed.
    Built-in scanners usually cannot be edited and return an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Scanner ID

    .PARAMETER BaseScannerId
    Base scanner ID

    .PARAMETER CommandSetId
    Command set ID

    .PARAMETER InputScanItemTemplateId
    ID of the scan template the scanner takes as input

    .PARAMETER IsActive
    Make the scanner active, or inactive with -IsActive:$false

    .PARAMETER ItemScannerDescription
    Scanner description

    .PARAMETER ItemScannerName
    Scanner name

    .PARAMETER OutputScanItemTemplateId
    ID of the scan template the scanner returns

    .PARAMETER ScannerId
    Scanner type ID

    .PARAMETER ScriptArguments
    Arguments passed to the scanner script

    .PARAMETER ScriptId
    ID of the script the scanner runs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryScanner -TssSession $session -Id 42 -ItemScannerName 'Find Linux accounts'

    Rename scanner 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryScanner -TssSession $session -Id 42 -IsActive:$false

    Make scanner 42 inactive

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryScanner

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryScanner.ps1

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
        [Alias('ItemScannerId')]
        [int]
        $Id,

        [int]
        $BaseScannerId,

        [int]
        $CommandSetId,

        [int]
        $InputScanItemTemplateId,

        [switch]
        $IsActive,

        [string]
        $ItemScannerDescription,

        [string]
        $ItemScannerName,

        [int]
        $OutputScanItemTemplateId,

        [int]
        $ScannerId,

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
            $uri = $TssSession.ApiUrl, 'discovery', 'scanners', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'BaseScannerId' {
                    $body.data.Add('baseScannerId', @{ dirty = $true; value = $BaseScannerId })
                }
                'CommandSetId' {
                    $body.data.Add('commandSetId', @{ dirty = $true; value = $CommandSetId })
                }
                'InputScanItemTemplateId' {
                    $body.data.Add('inputScanItemTemplateId', @{ dirty = $true; value = $InputScanItemTemplateId })
                }
                'IsActive' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$IsActive })
                }
                'ItemScannerDescription' {
                    $body.data.Add('itemScannerDescription', @{ dirty = $true; value = $ItemScannerDescription })
                }
                'ItemScannerName' {
                    $body.data.Add('itemScannerName', @{ dirty = $true; value = $ItemScannerName })
                }
                'OutputScanItemTemplateId' {
                    $body.data.Add('outputScanItemTemplateId', @{ dirty = $true; value = $OutputScanItemTemplateId })
                }
                'ScannerId' {
                    $body.data.Add('scannerId', @{ dirty = $true; value = $ScannerId })
                }
                'ScriptArguments' {
                    $body.data.Add('scriptArguments', @{ dirty = $true; value = $ScriptArguments })
                }
                'ScriptId' {
                    $body.data.Add('scriptId', @{ dirty = $true; value = $ScriptId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery scanner: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryScanner request'
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
