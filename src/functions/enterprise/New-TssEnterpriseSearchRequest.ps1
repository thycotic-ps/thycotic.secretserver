function New-TssEnterpriseSearchRequest {
    <#
    .SYNOPSIS
    Start an enterprise search request

    .DESCRIPTION
    Starts a search of the enterprise data of the named enterprise between two dates and returns the request ID.
    Read the result with Get-TssEnterpriseSearchRequest.
    EnterpriseName must match an enterprise configured on the server.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnterpriseName
    Name of the enterprise to search

    .PARAMETER StartDate
    Start of the date range to search

    .PARAMETER EndDate
    End of the date range to search

    .PARAMETER RequestField
    Field filters as a hashtable of field name and value, for example @{ SecretName = 'web' }

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssEnterpriseSearchRequest -TssSession $session -EnterpriseName 'Contoso' -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)

    Starts an enterprise search over the last 7 days and returns its RequestId

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/enterprise/New-TssEnterpriseSearchRequest

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/enterprise/New-TssEnterpriseSearchRequest.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Enterprise.SearchRequest')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $EnterpriseName,

        [datetime]
        $StartDate,

        [datetime]
        $EndDate,

        [hashtable]
        $RequestField
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'enterprise', 'search-request' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EnterpriseName' {
                    $body.data.Add('enterpriseName', $EnterpriseName)
                }
                'StartDate' {
                    $body.data.Add('startDate', $StartDate.ToUniversalTime().ToString('o'))
                }
                'EndDate' {
                    $body.data.Add('endDate', $EndDate.ToUniversalTime().ToString('o'))
                }
                'RequestField' {
                    $requestFields = @(foreach ($fieldName in $RequestField.Keys) {
                            @{
                                fieldName  = $fieldName
                                fieldValue = $RequestField[$fieldName]
                            }
                        })
                    $body.data.Add('requestFields', $requestFields)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Enterprise search request", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssEnterpriseSearchRequest request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Enterprise.SearchRequest](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Enterprise.SearchRequest]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
