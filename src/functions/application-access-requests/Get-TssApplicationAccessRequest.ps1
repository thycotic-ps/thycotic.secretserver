function Get-TssApplicationAccessRequest {
    <#
    .SYNOPSIS
    Get an application access request by device ID

    .DESCRIPTION
    Application access requests are created by Privilege Manager when an application on a managed device asks for access through Secret Server.
    Returns the request for the given device ID with its status (Approved, Pending or Denied).
    Without permission to manage application access requests the server answers API_AccessDenied.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Device ID of the application access request

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssApplicationAccessRequest -TssSession $session -Id 12

    Get the application access request of device 12

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/application-access-requests/Get-TssApplicationAccessRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/application-access-requests/Get-TssApplicationAccessRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ApplicationAccessRequests.Request')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('DeviceId')]
        [int[]]
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
                $uri = $TssSession.ApiUrl, 'application-access-request', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssApplicationAccessRequest request'
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
