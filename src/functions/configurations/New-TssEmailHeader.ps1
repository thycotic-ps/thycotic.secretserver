function New-TssEmailHeader {
    <#
    .SYNOPSIS
    Create a custom email message header

    .DESCRIPTION
    Create a custom header that Secret Server adds to every outgoing email. Only the parameters you pass are sent, so omit -Active to create the header inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Active
    Create the header active

    .PARAMETER HeaderName
    Name of the header, for example X-Mailer-Source

    .PARAMETER HeaderValue
    Value of the header

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssEmailHeader -TssSession $session -HeaderName X-Mailer-Source -HeaderValue SecretServer -Active

    Add the active header X-Mailer-Source: SecretServer to every outgoing email

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/New-TssEmailHeader

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/New-TssEmailHeader.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.EmailHeader')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $Active,

        [Parameter(Mandatory)]
        [string]
        $HeaderName,

        [Parameter(Mandatory)]
        [string]
        $HeaderValue
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
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', [boolean]$Active)
                }
                'HeaderName' {
                    $body.data.Add('headerName', $HeaderName)
                }
                'HeaderValue' {
                    $body.data.Add('headerValue', $HeaderValue)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Email header", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssEmailHeader request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.EmailHeader](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.EmailHeader]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
