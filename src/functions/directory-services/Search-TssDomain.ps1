function Search-TssDomain {
    <#
    .SYNOPSIS
    Search the domains a user can log in with

    .DESCRIPTION
    List the ID and name of the active directory domains, the list Secret Server offers on its login page. Inactive domains are not returned; Search-TssDirectoryServiceDomain lists every domain with its settings.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDomain -TssSession $session

    List the domains users can log in with

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDomain

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDomain.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.DomainLookup[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'domains' -join '/'
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
                Write-Warning 'Issue with Search-TssDomain request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DirectoryServices.DomainLookup[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DirectoryServices.DomainLookup]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
