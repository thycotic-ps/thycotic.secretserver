function Get-TssDiscoveryComputer {
    <#
    .SYNOPSIS
    Get a discovered computer

    .DESCRIPTION
    Returns the detail of one or more discovered computers by id, including their accounts. With Services, returns the service accounts discovered on the computer instead.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovered computer id

    .PARAMETER Services
    Return the service accounts discovered on the computer

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryComputer -TssSession $session -Id 42

    Get the detail of discovered computer 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryComputer -TssSession $session -Id 42 -Services

    Get the service accounts discovered on computer 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryComputer

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryComputer.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Discovery.Computer', ParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Discovery.ComputerServiceAccount[]', ParameterSetName = 'Services')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Services')]
        [Alias('ComputerId', 'NetworkItemId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Services')]
        [switch]
        $Services
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
                switch ($PSCmdlet.ParameterSetName) {
                    'Services' {
                        $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'computer', $currentId, 'services' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'computer', $currentId -join '/'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoveryComputer request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($PSCmdlet.ParameterSetName -eq 'Services') {
                    if ($restResponse.records) {
                        [Thycotic.PowerShell.Discovery.ComputerServiceAccount[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.ComputerServiceAccount]))
                    }
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Discovery.Computer](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.Computer]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
