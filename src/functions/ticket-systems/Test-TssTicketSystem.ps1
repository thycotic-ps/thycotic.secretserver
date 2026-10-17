function Test-TssTicketSystem {
    <#
    .SYNOPSIS
    Test a ticket number against a ticket system

    .DESCRIPTION
    Checks a sample ticket number the way Secret Server checks one on an access request: against the validation regular expression, or through the ServiceNow, BMC Remedy or PowerShell integration. Inactive ticket systems are tested too; nothing is saved.
    Returns Success False with the reason in ErrorMessage when the ticket number is rejected. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Ticket system ID

    .PARAMETER TicketNumber
    Ticket number to test

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssTicketSystem -TssSession $session -Id 3 -TicketNumber 'CHG0012345'

    Check whether ticket system 3 accepts ticket number CHG0012345

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/ticket-systems/Test-TssTicketSystem

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/ticket-systems/Test-TssTicketSystem.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.TicketSystems.TestResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TicketSystemId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [string]
        $TicketNumber
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'ticket-systems', $Id, 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'TicketNumber' {
                    $body.data.Add('ticketNumber', $TicketNumber)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssTicketSystem request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.TicketSystems.TestResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.TicketSystems.TestResult]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
