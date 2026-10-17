function New-TssDiscoveryCommandSet {
    <#
    .SYNOPSIS
    Create a Discovery command set

    .DESCRIPTION
    Creates an SSH or ODBC command set that Discovery runs to find machines or accounts. Returns the created command set.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

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
    New-TssDiscoveryCommandSet -TssSession $session -CommandSetName 'Linux local users' -Commands 'cat /etc/passwd' -DiscoveryScannerId 1 -ScanTypeId 3 -IsActive

    Create an active SSH command set that finds local accounts

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/New-TssDiscoveryCommandSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/New-TssDiscoveryCommandSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.CommandSet')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Commands,

        [Parameter(Mandatory)]
        [string]
        $CommandSetName,

        [Parameter(Mandatory)]
        [ValidateSet('1', '2')]
        [int]
        $DiscoveryScannerId,

        [switch]
        $IsActive,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'command-sets' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Commands' {
                    $body.data.Add('commands', $Commands)
                }
                'CommandSetName' {
                    $body.data.Add('commandSetName', $CommandSetName)
                }
                'DiscoveryScannerId' {
                    $body.data.Add('discoveryScannerId', $DiscoveryScannerId)
                }
                'IsActive' {
                    $body.data.Add('isActive', [boolean]$IsActive)
                }
                'ScanTypeId' {
                    $body.data.Add('scanTypeId', $ScanTypeId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery command set", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssDiscoveryCommandSet request'
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
