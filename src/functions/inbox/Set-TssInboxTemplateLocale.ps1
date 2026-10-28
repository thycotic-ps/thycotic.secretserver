function Set-TssInboxTemplateLocale {
    <#
    .SYNOPSIS
    Change the subject or body of an inbox template locale

    .DESCRIPTION
    Changes the subject or body an inbox notification template uses for one locale. Only the values you pass are changed.
    The locale must already exist on the template: add one with New-TssInboxTemplateLocale. The locale is chosen by locale culture ID, not by template locale ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateId
    Inbox template ID

    .PARAMETER LocaleCultureId
    Locale culture ID

    .PARAMETER Subject
    New subject

    .PARAMETER TemplateBody
    New body (HTML for email templates)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxTemplateLocale -TssSession $session -TemplateId 15 -LocaleCultureId 9 -Subject 'Secret changed: $SecretName'

    Change the subject of locale culture 9 on inbox template 15

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxTemplate -TssSession $session -Id 15 | Set-TssInboxTemplateLocale -TssSession $session -TemplateBody (Get-Content .\body.html -Raw)

    Replace the body of the default locale of inbox template 15 with the contents of body.html

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxTemplateLocale

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxTemplateLocale.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Inbox.TemplateLocale')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $TemplateId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Locale', 'LocaleId')]
        [int]
        $LocaleCultureId,

        [string]
        $Subject,

        [string]
        $TemplateBody
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'inbox', 'templates', $TemplateId, 'locales', $LocaleCultureId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Subject' {
                    $body.data.Add('subject', @{ dirty = $true; value = $Subject })
                }
                'TemplateBody' {
                    $body.data.Add('templateBody', @{ dirty = $true; value = $TemplateBody })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox template locale: $TemplateId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssInboxTemplateLocale request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Inbox.TemplateLocale](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.TemplateLocale]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
