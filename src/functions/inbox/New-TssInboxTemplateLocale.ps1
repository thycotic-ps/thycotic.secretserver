function New-TssInboxTemplateLocale {
    <#
    .SYNOPSIS
    Add a locale to an inbox notification template

    .DESCRIPTION
    Adds a subject and body for another locale culture to an inbox notification template.
    A template has one locale per locale culture ID: adding a culture the template already has is rejected. Change an existing locale with Set-TssInboxTemplateLocale.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateId
    Inbox template ID

    .PARAMETER LocaleCultureId
    Locale culture ID of the new locale

    .PARAMETER Subject
    Subject for this locale

    .PARAMETER TemplateBody
    Body for this locale (HTML for email templates)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxTemplateLocale -TssSession $session -TemplateId 15 -LocaleCultureId 10 -Subject 'Secret geaendert' -TemplateBody '<p>$Details</p>'

    Add locale culture 10 to inbox template 15

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxTemplateLocale -TssSession $session -TemplateId 15 -LocaleCultureId 10 -Subject 'Test' -TemplateBody '<p>Test</p>' -WhatIf

    Show the request without adding the locale

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplateLocale

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplateLocale.ps1

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
        [Alias('InboxTemplateId')]
        [int]
        $TemplateId,

        [Parameter(Mandatory)]
        [int]
        $LocaleCultureId,

        [Parameter(Mandatory)]
        [string]
        $Subject,

        [Parameter(Mandatory)]
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
            $uri = $TssSession.ApiUrl, 'inbox', 'templates', 'template-locale' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'TemplateId' {
                    $body.data.Add('inboxTemplateId', $TemplateId)
                }
                'LocaleCultureId' {
                    $body.data.Add('localeCultureId', $LocaleCultureId)
                }
                'Subject' {
                    $body.data.Add('subject', $Subject)
                }
                'TemplateBody' {
                    $body.data.Add('templateBody', $TemplateBody)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox template locale", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssInboxTemplateLocale request'
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
