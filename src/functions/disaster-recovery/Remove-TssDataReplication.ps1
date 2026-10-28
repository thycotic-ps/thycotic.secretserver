function Remove-TssDataReplication {
    <#
    .SYNOPSIS
    Remove a Disaster Recovery data replica

    .DESCRIPTION
    Deletes a data replica registration from this Secret Server (the Disaster Recovery data source). The replica no longer receives data from this Secret Server.
    Replica ids are Guids, returned in the DataReplicas property of Get-TssOutgoingDrConfiguration. Requires the Administer Disaster Recovery permission. An unknown id returns an access denied error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Data replica id (Guid)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0

    Remove one data replica

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0 -WhatIf

    Show the request that would remove the data replica, without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Remove-TssDataReplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Remove-TssDataReplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
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
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Data replica: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssDataReplication request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ([System.Convert]::ToBoolean($restResponse)) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $currentId
                            ObjectType = 'DataReplica'
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
