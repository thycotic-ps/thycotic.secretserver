function New-TssInboxTemplate {
    <#
    .SYNOPSIS
    Create an inbox notification template

    .DESCRIPTION
    Creates an empty inbox notification template that inbox rules can use for email or Slack messages.
    The template gets a default locale with an empty subject and body. Fill them in with Set-TssInboxTemplateLocale.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateName
    Name of the template

    .PARAMETER TemplateType
    Template type: Email (default) or Slack

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxTemplate -TssSession $session -TemplateName 'Weekly digest'

    Create an email template named Weekly digest

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $template = New-TssInboxTemplate -TssSession $session -TemplateName 'Ops Slack' -TemplateType Slack
    Set-TssInboxTemplateLocale -TssSession $session -TemplateId $template.TemplateId -LocaleCultureId $template.Locale -TemplateBody '$Details'

    Create a Slack template and set the body of its default locale

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Inbox.Template')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('Name')]
        [string]
        $TemplateName,

        [ValidateSet('Email', 'Slack')]
        [string]
        $TemplateType = 'Email'
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
            $uri = $TssSession.ApiUrl, 'inbox', 'templates' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                data = @{
                    templateName = $TemplateName
                    templateType = $TemplateType
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssInboxTemplate request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Inbox.Template](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.Template]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
