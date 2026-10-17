function Set-TssInboxTemplate {
    <#
    .SYNOPSIS
    Rename an inbox notification template or change its type

    .DESCRIPTION
    Changes the name or type of a custom inbox notification template. Only the values you pass are changed.
    System templates cannot be changed: the server rejects the request. Copy one with Copy-TssInboxTemplate and change the copy.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox template ID

    .PARAMETER TemplateName
    New name of the template

    .PARAMETER TemplateType
    New template type: Email or Slack

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxTemplate -TssSession $session -Id 15 -TemplateName 'Weekly digest v2'

    Rename inbox template 15

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssInboxTemplate -TssSession $session -Id 15 -TemplateType Slack -WhatIf

    Show the request that would change template 15 to a Slack template

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Set-TssInboxTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Set-TssInboxTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Inbox.Template')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TemplateId')]
        [int]
        $Id,

        [string]
        $TemplateName,

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
            $uri = $TssSession.ApiUrl, 'inbox', 'templates', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'TemplateName' {
                    $body.data.Add('templateName', @{ dirty = $true; value = $TemplateName })
                }
                'TemplateType' {
                    $body.data.Add('templateType', @{ dirty = $true; value = $TemplateType })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox template: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssInboxTemplate request'
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
