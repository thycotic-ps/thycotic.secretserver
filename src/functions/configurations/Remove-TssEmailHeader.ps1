function Remove-TssEmailHeader {
    <#
    .SYNOPSIS
    Remove a custom email message header

    .DESCRIPTION
    Remove a custom email message header by Id. Returns whether the delete succeeded.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Id (GUID) of the email header

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEmailHeader -TssSession $session | Where-Object HeaderName -EQ X-Mailer-Source | Remove-TssEmailHeader -TssSession $session

    Remove the X-Mailer-Source header

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Remove-TssEmailHeader

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Remove-TssEmailHeader.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.EmailHeaderDeleteResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
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
                $uri = $TssSession.ApiUrl, 'configuration', 'email', 'email-message-header', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Email header: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssEmailHeader request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Configuration.EmailHeaderDeleteResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.EmailHeaderDeleteResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
