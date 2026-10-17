function Get-TssTicketSystem {
    <#
    .SYNOPSIS
    Get a ticket system

    .DESCRIPTION
    Returns the full settings of a ticket system: type, ticket number requirement and validation, override approval settings and the ServiceNow, BMC Remedy and PowerShell integration fields.
    Use -Legacy for the shorter version 1 shape, where the type and the ticket number requirement are numeric IDs.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Ticket system ID

    .PARAMETER Legacy
    Use the version 1 route, which returns the shorter Summary shape with numeric type and requirement IDs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssTicketSystem -TssSession $session -Id 3

    Get the settings of ticket system 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssTicketSystem -TssSession $session -IncludeInactive | Get-TssTicketSystem -TssSession $session | Select-Object Name, TicketSystemType, Active, EnableTicketOverride

    List the type and override setting of every ticket system

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Get-TssTicketSystem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Get-TssTicketSystem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.TicketSystems.TicketSystem', 'Thycotic.PowerShell.TicketSystems.Summary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TicketSystemId')]
        [int[]]
        $Id,

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
            foreach ($currentId in $Id) {
                $restResponse = $null
                switch ($PSCmdlet.ParameterSetName) {
                    'Legacy' {
                        $uri = $TssSession.ApiUrl, 'ticket-systems', $currentId -join '/'
                    }
                    default {
                        $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'ticket-systems', $currentId -join '/'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssTicketSystem request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -and $Legacy) {
                    [Thycotic.PowerShell.TicketSystems.Summary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.TicketSystems.Summary]))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.TicketSystems.TicketSystem](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.TicketSystems.TicketSystem]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
