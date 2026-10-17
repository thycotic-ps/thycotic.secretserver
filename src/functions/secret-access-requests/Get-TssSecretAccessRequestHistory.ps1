function Get-TssSecretAccessRequestHistory {
    <#
    .SYNOPSIS
    Get the history of a secret access request

    .DESCRIPTION
    Returns the actions recorded for a secret access request (created, approved, denied, canceled, expired), with the date and the user who acted.
    The history is returned to the user that created the request.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret access request ID

    .PARAMETER V2
    Use the v2 endpoint. Both versions return the same history

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretAccessRequestHistory -TssSession $session -Id 17

    Get the history of access request 17

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretAccessRequest -TssSession $session -Status Approved | Get-TssSecretAccessRequestHistory -TssSession $session -V2

    Get the history of every approved request of the current user, using the v2 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-access-requests/Get-TssSecretAccessRequestHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-access-requests/Get-TssSecretAccessRequestHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.AccessRequests.History[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'V2')]
        [Alias('SecretAccessRequestId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'V2')]
        [switch]
        $V2
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
                switch ($PSCmdlet.ParameterSetName) {
                    'V2' {
                        $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secret-access-requests', $currentId, 'history' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'secret-access-requests', $currentId, 'history' -join '/'
                        $queryParams = @()
                        $queryParams += "take=$($TssSession.Take)"
                        if ($queryParams) {
                            $uri = $uri, ($queryParams -join '&') -join '?'
                        }
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretAccessRequestHistory request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.AccessRequests.History[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.AccessRequests.History]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
