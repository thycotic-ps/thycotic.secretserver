function Set-TssEmailHeader {
    <#
    .SYNOPSIS
    Set a custom email message header

    .DESCRIPTION
    Change the name, value or active state of a custom email message header. Only the parameters you pass are sent. Returns the header after the update.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Id (GUID) of the email header

    .PARAMETER Active
    Make the header active; pass -Active:$false to deactivate it

    .PARAMETER HeaderName
    New name of the header

    .PARAMETER HeaderValue
    New value of the header

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEmailHeader -TssSession $session | Where-Object HeaderName -EQ X-Mailer-Source | Set-TssEmailHeader -TssSession $session -Active:$false

    Deactivate the X-Mailer-Source header

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssEmailHeader

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssEmailHeader.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.EmailHeader')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $Id,

        [switch]
        $Active,

        [string]
        $HeaderName,

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
            $uri = $TssSession.ApiUrl, 'configuration', 'email', 'email-message-header', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            $body.data.Add('id', $Id)
            switch ($tssParams.Keys) {
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
                'HeaderName' {
                    $body.data.Add('headerName', @{ dirty = $true; value = $HeaderName })
                }
                'HeaderValue' {
                    $body.data.Add('headerValue', @{ dirty = $true; value = $HeaderValue })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Email header: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                $restResponse = $null
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssEmailHeader request'
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
