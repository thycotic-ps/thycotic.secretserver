function Set-TssDataReplication {
    <#
    .SYNOPSIS
    Update a Disaster Recovery data replica

    .DESCRIPTION
    Changes the name, approval status or replicated folders of a data replica registered with this Secret Server. Only the values you pass are changed.
    A replica registers itself as Unapproved; set -Status Approved to start sending it data, or Disabled to stop. -FolderIds with -IsFoldersBlockList picks which folders are replicated.
    Replica ids are Guids, returned in the DataReplicas property of Get-TssOutgoingDrConfiguration. Requires the Administer Disaster Recovery permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Data replica id (Guid)

    .PARAMETER FolderIds
    Folder ids the replica list applies to. With -IsFoldersBlockList these folders are excluded, otherwise only these folders are replicated

    .PARAMETER IsFoldersBlockList
    Treat -FolderIds as folders to exclude from replication instead of the folders to include

    .PARAMETER Name
    Display name of the data replica

    .PARAMETER Status
    Approval status of the data replica: Unapproved, Approved or Disabled

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0 -Status Approved

    Approve a data replica so it starts receiving data

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDataReplication -TssSession $session -Id 0b1c2d3e-4f50-6172-8394-a5b6c7d8e9f0 -FolderIds 12, 15 -IsFoldersBlockList

    Replicate every folder except folders 12 and 15 to the data replica

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Set-TssDataReplication

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Set-TssDataReplication.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.DataReplication')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReplicaId')]
        [string]
        $Id,

        [int[]]
        $FolderIds,

        [switch]
        $IsFoldersBlockList,

        [string]
        $Name,

        [ValidateSet('Unapproved', 'Approved', 'Disabled')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'data-replication', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'FolderIds' {
                    $body.data.Add('folderIds', @{ dirty = $true; value = $FolderIds })
                }
                'IsFoldersBlockList' {
                    $body.data.Add('isFoldersBlockList', @{ dirty = $true; value = [boolean]$IsFoldersBlockList })
                }
                'Name' {
                    $body.data.Add('name', @{ dirty = $true; value = $Name })
                }
                'Status' {
                    $body.data.Add('status', @{ dirty = $true; value = $Status })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $restResponse = $null
            if ($PSCmdlet.ShouldProcess("Data replica: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDataReplication request'
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
