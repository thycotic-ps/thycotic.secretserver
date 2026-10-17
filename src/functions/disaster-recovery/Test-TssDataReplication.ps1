function Test-TssDataReplication {
    <#
    .SYNOPSIS
    Test the Disaster Recovery data replication connection

    .DESCRIPTION
    Tests the connection from this Secret Server (a Disaster Recovery data replica) to its configured data source.
    The output Success and Message properties give the result. When data replication is not enabled the server returns an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssDataReplication -TssSession $session

    Test the connection to the data source

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $result = Test-TssDataReplication -TssSession $session
    if (-not $result.Success) { $result.Message }

    Show the failure message when the connection test fails

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Test-TssDataReplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Test-TssDataReplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage')]
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
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'data-replication', 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssDataReplication request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.DataReplicationMessage]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
