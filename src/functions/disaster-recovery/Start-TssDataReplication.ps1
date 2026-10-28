function Start-TssDataReplication {
    <#
    .SYNOPSIS
    Start Disaster Recovery data replication now

    .DESCRIPTION
    Runs data replication now on this Secret Server when it is a Disaster Recovery data replica, instead of waiting for the replication interval.
    With -DataSince only changes made after that time are replicated. The output Success and Message properties say whether replication was queued; when data replication is not enabled Success is False.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DataSince
    Only replicate changes made after this date and time. Sent to the server in UTC

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssDataReplication -TssSession $session

    Start data replication now

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssDataReplication -TssSession $session -DataSince (Get-Date).AddDays(-1)

    Replicate only the changes made in the last day

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Start-TssDataReplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Start-TssDataReplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $DataSince
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'data-replication', 'run-now' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'DataSince' {
                    $queryParams += "dataSince=$([uri]::EscapeDataString($DataSince.ToUniversalTime().ToString('o')))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Data replication", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssDataReplication request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
