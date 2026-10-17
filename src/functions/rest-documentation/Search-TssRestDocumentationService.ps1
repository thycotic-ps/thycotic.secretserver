function Search-TssRestDocumentationService {
    <#
    .SYNOPSIS
    List the REST API services documented by Secret Server

    .DESCRIPTION
    Returns the REST API service groups (name, display name and description) listed in the REST API documentation of the instance.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRestDocumentationService -TssSession $session

    Returns the documented REST API services

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/rest-documentation/Search-TssRestDocumentationService

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/rest-documentation/Search-TssRestDocumentationService.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.RestDocumentation.Service[]')]
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
            $uri = $TssSession.ApiUrl, 'rest-documentation', 'services' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssRestDocumentationService request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.RestDocumentation.Service[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.RestDocumentation.Service]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
