function Get-TssOutgoingDrConfiguration {
    <#
    .SYNOPSIS
    Get the Disaster Recovery outgoing configuration

    .DESCRIPTION
    Gets the Disaster Recovery settings of this Secret Server as a data source: the data source URL and public key replicas use, the data package storage path and the registered data replicas.
    -Name and -Location filter the data replicas returned in DataReplicas. A Secret Server with no data replicas returns an empty DataReplicas list.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Location
    Only return data replicas whose location contains this text

    .PARAMETER Name
    Only return data replicas whose name contains this text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssOutgoingDrConfiguration -TssSession $session

    Get the outgoing configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssOutgoingDrConfiguration -TssSession $session -Name dr).DataReplicas | Select-Object Id, Name, Status, LastReplicated

    List the data replicas whose name contains dr

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/disaster-recovery/Get-TssOutgoingDrConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/disaster-recovery/Get-TssOutgoingDrConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DisasterRecovery.OutgoingDrConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $Location,

        [string]
        $Name
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'disaster-recovery', 'outgoing-configuration' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'Location' {
                    $queryParams += "filter.location=$([uri]::EscapeDataString($Location))"
                }
                'Name' {
                    $queryParams += "filter.name=$([uri]::EscapeDataString($Name))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssOutgoingDrConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DisasterRecovery.OutgoingDrConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DisasterRecovery.OutgoingDrConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
