function Search-TssEmailHeader {
    <#
    .SYNOPSIS
    Search custom email message headers

    .DESCRIPTION
    Get every custom header Secret Server adds to outgoing email, active and inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEmailHeader -TssSession $session

    List the custom email headers

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssEmailHeader

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssEmailHeader.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.EmailHeader[]')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'email', 'email-message-header' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssEmailHeader request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                foreach ($record in $restResponse) {
                    [Thycotic.PowerShell.Configuration.EmailHeader]@{
                        Active      = $record.active.value
                        HeaderName  = $record.headerName.value
                        HeaderValue = $record.headerValue.value
                        Id          = $record.id.value
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
