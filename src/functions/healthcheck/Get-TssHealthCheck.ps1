function Get-TssHealthCheck {
    <#
    .SYNOPSIS
    Get the health check of Secret Server

    .DESCRIPTION
    Get whether Secret Server and its database are healthy, whether it runs in read-only mode and, on Secret Server Cloud, the state of the service bus and storage accounts. Values that do not apply to the instance are empty.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssHealthCheck -TssSession $session).Healthy

    Show whether Secret Server reports itself healthy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/healthcheck/Get-TssHealthCheck

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/healthcheck/Get-TssHealthCheck.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.HealthCheck.Status')]
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
            $uri = $TssSession.ApiUrl, 'healthcheck' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssHealthCheck request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.HealthCheck.Status](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.HealthCheck.Status]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
