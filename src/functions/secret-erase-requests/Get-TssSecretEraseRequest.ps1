function Get-TssSecretEraseRequest {
    <#
    .SYNOPSIS
    Get a secret erase request

    .DESCRIPTION
    Returns a secret erase request: requester, comment, number of secrets, status, erase after date and whether you can approve, deny or cancel it.
    Requires the Secret Erase feature.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret erase request ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretEraseRequest -TssSession $session -Id 17

    Returns secret erase request 17

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EraseRequests.Request')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretEraseRequestId')]
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
                $uri = $TssSession.ApiUrl, 'secret-erase-requests', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretEraseRequest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EraseRequests.Request](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EraseRequests.Request]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
