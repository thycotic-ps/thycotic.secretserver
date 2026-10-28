function Search-TssTicketSystem {
    <#
    .SYNOPSIS
    Search ticket systems

    .DESCRIPTION
    Returns the ticket systems used with secret access requests and secret view comments: name, type, ticket number requirement, default and override settings. Active ticket systems only, unless -IncludeInactive is used.
    Use Get-TssTicketSystem for the integration settings of one ticket system. -V2 uses the version 2 route (same output) and -Legacy the version 1 route, which returns only the ID, name, description, URL pattern, display message, requirement, type ID, active and default properties.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER IncludeInactive
    Include inactive ticket systems

    .PARAMETER V2
    Use the version 2 route (same output)

    .PARAMETER Legacy
    Use the version 1 route, which returns fewer properties

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTicketSystem -TssSession $session

    List the active ticket systems

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTicketSystem -TssSession $session -IncludeInactive | Where-Object IsDefault

    Find the default ticket system

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Search-TssTicketSystem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Search-TssTicketSystem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.TicketSystems.Summary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $IncludeInactive,

        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [switch]
        $V2,

        [Parameter(Mandatory, ParameterSetName = 'Legacy')]
        [switch]
        $Legacy
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $queryParams = @()
            switch ($PSCmdlet.ParameterSetName) {
                'V2' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'ticket-systems' -join '/'
                    $queryParams += "take=$($TssSession.Take)"
                    $queryParams += "includeInactive=$([boolean]$IncludeInactive)"
                }
                'Legacy' {
                    $uri = $TssSession.ApiUrl, 'ticket-systems' -join '/'
                    $queryParams += "includeInactive=$([boolean]$IncludeInactive)"
                }
                default {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'ticket-systems' -join '/'
                    $queryParams += "take=$($TssSession.Take)"
                    if ($tssParams.ContainsKey('IncludeInactive')) {
                        $queryParams += "filter.includeInactive=$([boolean]$IncludeInactive)"
                    }
                }
            }
            $uri = $uri, ($queryParams -join '&') -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssTicketSystem request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($Legacy -and $restResponse) {
                [Thycotic.PowerShell.TicketSystems.Summary[]](. $FilterTssResponse @($restResponse) ([Thycotic.PowerShell.TicketSystems.Summary]))
            } elseif ($restResponse.records) {
                [Thycotic.PowerShell.TicketSystems.Summary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.TicketSystems.Summary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
