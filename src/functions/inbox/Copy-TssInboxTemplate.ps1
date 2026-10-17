function Copy-TssInboxTemplate {
    <#
    .SYNOPSIS
    Copy an inbox notification template

    .DESCRIPTION
    Creates a new inbox notification template as a copy of an existing one, under a new name.
    The copy is never a system template, so it can be changed with Set-TssInboxTemplate and Set-TssInboxTemplateLocale even when the source is a built-in template.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the inbox template to copy

    .PARAMETER Name
    Name of the new template

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Copy-TssInboxTemplate -TssSession $session -Id 4 -Name 'Password Reset (branded)'

    Copy template 4 to a new template named Password Reset (branded)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxTemplate -TssSession $session -TemplateType Slack | Select-Object -First 1 | Copy-TssInboxTemplate -TssSession $session -Name 'Team Slack'

    Copy the first Slack template to a new template named Team Slack

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Copy-TssInboxTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Copy-TssInboxTemplate.ps1

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
        [Alias('TemplateId', 'InboxTemplateIdToCopy')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [string]
        $Name
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
            $uri = $TssSession.ApiUrl, 'inbox', 'templates', 'copy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Id' {
                    $body.data.Add('inboxTemplateIdToCopy', $Id)
                }
                'Name' {
                    $body.data.Add('name', $Name)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox template", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Copy-TssInboxTemplate request'
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
