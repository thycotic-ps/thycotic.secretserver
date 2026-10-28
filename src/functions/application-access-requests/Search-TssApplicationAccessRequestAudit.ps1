function Search-TssApplicationAccessRequestAudit {
    <#
    .SYNOPSIS
    Search the audit records of application access requests

    .DESCRIPTION
    Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
    Returns the audit records (action, date, IP address) of the application access request of one device. The device ID is required: without it the server answers 500.
    Without permission to manage application access requests the server answers API_AccessDenied.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DeviceId
    Device ID whose audit records to return; required by the server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssApplicationAccessRequestAudit -TssSession $session -DeviceId 12

    List the audit records of the application access request of device 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Search-TssApplicationAccessRequestAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Search-TssApplicationAccessRequestAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ApplicationAccessRequests.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $DeviceId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'application-access-request-audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'DeviceId' {
                    $queryParams += "filter.deviceId=$($DeviceId)"
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
                Write-Warning 'Issue with Search-TssApplicationAccessRequestAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.ApplicationAccessRequests.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ApplicationAccessRequests.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
