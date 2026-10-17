function Get-TssDataReplication {
    <#
    .SYNOPSIS
    Get a Disaster Recovery data replica

    .DESCRIPTION
    Gets a data replica registered with this Secret Server as a Disaster Recovery data source: name, location, status, replicated folders and the last replication time.
    Replica ids are Guids, returned in the DataReplicas property of Get-TssOutgoingDrConfiguration. An unknown id returns an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Data replica id (Guid)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0

    Get one data replica by id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssOutgoingDrConfiguration -TssSession $session).DataReplicas | Get-TssDataReplication -TssSession $session

    Get every data replica registered with this Secret Server

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssDataReplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssDataReplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.DataReplication')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReplicaId')]
        [string[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'disaster-recovery', 'data-replication', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDataReplication request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DisasterRecovery.DataReplication](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.DataReplication]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
