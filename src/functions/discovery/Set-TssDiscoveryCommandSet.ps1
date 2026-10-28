function Set-TssDiscoveryCommandSet {
    <#
    .SYNOPSIS
    Update a Discovery command set

    .DESCRIPTION
    Updates only the fields passed; omitted fields stay unchanged. Returns the updated command set.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery command set id

    .PARAMETER Commands
    Commands to run, one per line. Each command may be preceded by one comment line starting with #

    .PARAMETER CommandSetName
    Command set name

    .PARAMETER DiscoveryScannerId
    Scanner: 1 = SSH, 2 = ODBC

    .PARAMETER IsActive
    Make the command set active

    .PARAMETER ScanTypeId
    Scan type: 2 = machines, 3 = accounts

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDiscoveryCommandSet -TssSession $session -Id 5 -IsActive:$false

    Deactivate Discovery command set 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Set-TssDiscoveryCommandSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Set-TssDiscoveryCommandSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.CommandSet')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CommandSetId', 'DiscoveryCommandSetId')]
        [int]
        $Id,

        [string]
        $Commands,

        [string]
        $CommandSetName,

        [ValidateSet('1', '2')]
        [int]
        $DiscoveryScannerId,

        [switch]
        $IsActive,

        [ValidateSet('2', '3')]
        [int]
        $ScanTypeId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'command-sets', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Commands' {
                    $body.data.Add('commands', @{ dirty = $true; value = $Commands })
                }
                'CommandSetName' {
                    $body.data.Add('commandSetName', @{ dirty = $true; value = $CommandSetName })
                }
                'DiscoveryScannerId' {
                    $body.data.Add('discoveryScannerId', @{ dirty = $true; value = $DiscoveryScannerId })
                }
                'IsActive' {
                    $body.data.Add('isActive', @{ dirty = $true; value = [boolean]$IsActive })
                }
                'ScanTypeId' {
                    $body.data.Add('scanTypeId', @{ dirty = $true; value = $ScanTypeId })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery command set: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDiscoveryCommandSet request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Discovery.CommandSet](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.CommandSet]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
