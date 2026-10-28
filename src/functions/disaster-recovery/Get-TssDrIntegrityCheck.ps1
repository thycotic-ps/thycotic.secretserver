function Get-TssDrIntegrityCheck {
    <#
    .SYNOPSIS
    Run a Disaster Recovery data integrity check

    .DESCRIPTION
    Builds a Disaster Recovery replication package on this Secret Server and checks it for errors, without sending it to any replica.
    The output lists the entity types checked, the errors and the warnings found. Success is True when no errors were found. Requires the Administer Disaster Recovery permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDrIntegrityCheck -TssSession $session

    Run the integrity check

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssDrIntegrityCheck -TssSession $session).Errors

    Show only the errors the integrity check found

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssDrIntegrityCheck

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssDrIntegrityCheck.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.DrIntegrityCheck')]
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
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'integrity-check' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDrIntegrityCheck request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DisasterRecovery.DrIntegrityCheck](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.DrIntegrityCheck]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
