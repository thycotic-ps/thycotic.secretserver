function Get-TssServiceBusStatus {
    <#
    .SYNOPSIS
    Get the service buses of a Secret Server Cloud tenant

    .DESCRIPTION
    Gets the Azure Service Bus namespaces the tenant uses to talk to its distributed engines: one object per service bus with its name and URL.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServiceBusStatus -TssSession $session

    Get the service buses of the tenant

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Get-TssServiceBusStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Get-TssServiceBusStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers Access denied.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.ServiceBus[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'diagnostics', 'service-bus' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssServiceBusStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.serviceBuses) {
                [Thycotic.PowerShell.Diagnostics.ServiceBus[]](. $FilterTssResponse $restResponse.serviceBuses ([Thycotic.PowerShell.Diagnostics.ServiceBus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
