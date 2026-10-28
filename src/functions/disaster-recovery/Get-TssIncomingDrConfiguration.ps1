function Get-TssIncomingDrConfiguration {
    <#
    .SYNOPSIS
    Get the Disaster Recovery incoming configuration

    .DESCRIPTION
    Gets the Disaster Recovery settings of this Secret Server as a data replica: whether data replication is enabled, the data source URL and public key, the replication interval, the replication status and the last replication time.
    A Secret Server that is not a data replica returns DataReplicationEnabled False.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssIncomingDrConfiguration -TssSession $session

    Get the incoming configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssIncomingDrConfiguration -TssSession $session | Select-Object DataReplicationEnabled, ReplicationStatus, LastReplicated

    Show whether this Secret Server replicates and when it last did

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssIncomingDrConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssIncomingDrConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'incoming-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssIncomingDrConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.IncomingDrConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
