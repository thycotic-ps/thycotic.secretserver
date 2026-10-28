function Remove-TssInboxTemplateResource {
    <#
    .SYNOPSIS
    Remove an image used by inbox notification templates

    .DESCRIPTION
    Deletes one or more embedded inbox template resources by ID.
    The server reports success even when the ID does not exist. Use Search-TssInboxTemplateResource to confirm the removal.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox template resource ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssInboxTemplateResource -TssSession $session -Id 3

    Remove inbox template resource 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssInboxTemplateResource -TssSession $session | Where-Object InboxResourceSlug -EQ 'old-logo' | Remove-TssInboxTemplateResource -TssSession $session

    Remove the resource with the slug old-logo

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Remove-TssInboxTemplateResource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Remove-TssInboxTemplateResource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('InboxResourceId')]
        [int[]]
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
                $uri = $TssSession.ApiUrl, 'inbox', 'templates', 'resources', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Inbox template resource: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssInboxTemplateResource request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse.success) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $currentId
                            ObjectType = 'InboxTemplateResource'
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
