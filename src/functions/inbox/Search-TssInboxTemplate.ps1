function Search-TssInboxTemplate {
    <#
    .SYNOPSIS
    Search inbox notification templates

    .DESCRIPTION
    Lists the inbox notification templates, both built-in system templates and custom ones, with the inbox rules that use each template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER TemplateType
    Only return templates of this type: Email or Slack

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxTemplate -TssSession $session

    List every inbox notification template

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxTemplate -TssSession $session -TemplateType Email | Where-Object { -not $_.IsSystem }

    List the custom email templates

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Search-TssInboxTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Search-TssInboxTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.TemplateSummary[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('Email', 'Slack')]
        [string]
        $TemplateType
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
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'TemplateType' {
                    $queryParams += "filter.templateType=$([uri]::EscapeDataString($TemplateType))"
                }
            }
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
                Write-Warning 'Issue with Search-TssInboxTemplate request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Inbox.TemplateSummary[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Inbox.TemplateSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
