function Get-TssEnterpriseSearchRequest {
    <#
    .SYNOPSIS
    Get the result of an enterprise search request

    .DESCRIPTION
    Returns the processing start and end time and the result rows (action, date, secret, secret template and user) of an enterprise search request started by New-TssEnterpriseSearchRequest, once the request has completed.
    Secret Server returns an error when the request ID does not exist.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Enterprise search request ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEnterpriseSearchRequest -TssSession $session -Id 12

    Returns the result of enterprise search request 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssEnterpriseSearchRequest -TssSession $session -EnterpriseName 'Contoso' -StartDate (Get-Date).AddDays(-30) -EndDate (Get-Date) | Get-TssEnterpriseSearchRequest -TssSession $session

    Starts an enterprise search over the last 30 days and reads its result

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/enterprise/Get-TssEnterpriseSearchRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/enterprise/Get-TssEnterpriseSearchRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Enterprise.SearchResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('RequestId')]
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
                $uri = $TssSession.ApiUrl, 'enterprise', 'search-request', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssEnterpriseSearchRequest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Enterprise.SearchResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Enterprise.SearchResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
