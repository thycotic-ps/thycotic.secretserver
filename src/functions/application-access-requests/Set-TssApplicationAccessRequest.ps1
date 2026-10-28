function Set-TssApplicationAccessRequest {
    <#
    .SYNOPSIS
    Approve or deny an application access request

    .DESCRIPTION
    Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
    Sets the status of the request for the given device ID and returns the updated request.
    Without permission to manage application access requests the server answers API_AccessDenied.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Device ID of the application access request

    .PARAMETER Status
    New status: Approved, Pending or Denied

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssApplicationAccessRequest -TssSession $session -Id 12 -Status Approved

    Approve the application access request of device 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssApplicationAccessRequest -TssSession $session -Status Pending | Set-TssApplicationAccessRequest -TssSession $session -Status Denied

    Deny every pending application access request

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Set-TssApplicationAccessRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Set-TssApplicationAccessRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.ApplicationAccessRequests.Request')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DeviceId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('Approved', 'Pending', 'Denied')]
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
            $uri = $TssSession.ApiUrl, 'application-access-request', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Status' {
                    $body.data.Add('status', @{ dirty = $true; value = $Status })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Application access request: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssApplicationAccessRequest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ApplicationAccessRequests.Request](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ApplicationAccessRequests.Request]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
