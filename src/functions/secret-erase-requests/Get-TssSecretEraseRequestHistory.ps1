function Get-TssSecretEraseRequestHistory {
    <#
    .SYNOPSIS
    Get the history of a secret erase request

    .DESCRIPTION
    Returns the actions recorded for a secret erase request: action, date, user and details.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret erase request ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretEraseRequestHistory -TssSession $session -Id 17

    Returns the history of secret erase request 17

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Get-TssSecretEraseRequestHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Get-TssSecretEraseRequestHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EraseRequests.History[]')]
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
                $uri = $TssSession.ApiUrl, 'secret-erase-requests', $currentId, 'history' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
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
                    Write-Warning 'Issue with Get-TssSecretEraseRequestHistory request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.EraseRequests.History[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.EraseRequests.History]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
