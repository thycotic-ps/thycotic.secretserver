function Get-TssDiscoveryDirectoryAccount {
    <#
    .SYNOPSIS
    Get a discovered directory account

    .DESCRIPTION
    Returns the detail of one or more directory accounts found by Discovery, including the computer, organizational unit and secret they are linked to. With Services, returns the service accounts linked to the directory account instead.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Network item id of the directory account

    .PARAMETER Services
    Return the services, scheduled tasks and application pools that run as the directory account

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryDirectoryAccount -TssSession $session -Id 120

    Get the detail of discovered directory account 120

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryDirectoryAccount -TssSession $session -Id 120 -Services

    Get the service accounts linked to directory account 120

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryDirectoryAccount

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryDirectoryAccount.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.Discovery.DirectoryAccount')]
    [OutputType('Thycotic.PowerShell.Discovery.DirectoryAccountService')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Services')]
        [Alias('NetworkItemId')]
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
                        $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'directory-account', $currentId, 'services' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'directory-account', $currentId -join '/'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoveryDirectoryAccount request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($PSCmdlet.ParameterSetName -eq 'Services') {
                    if ($restResponse.records) {
                        [Thycotic.PowerShell.Discovery.DirectoryAccountService[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Discovery.DirectoryAccountService]))
                    }
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Discovery.DirectoryAccount](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.DirectoryAccount]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
