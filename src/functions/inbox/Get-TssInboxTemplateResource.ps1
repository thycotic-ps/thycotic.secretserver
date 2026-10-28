function Get-TssInboxTemplateResource {
    <#
    .SYNOPSIS
    Get an image used by inbox notification templates

    .DESCRIPTION
    Gets one or more embedded inbox template resources by ID: the slug templates use to reference the image, its type and the image itself as a base64 string in ImageData.
    The server answers access denied for an ID that does not exist. Use Search-TssInboxTemplateResource to find IDs.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Inbox template resource ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssInboxTemplateResource -TssSession $session -Id 3

    Get inbox template resource 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $resource = Get-TssInboxTemplateResource -TssSession $session -Id 3
    [System.IO.File]::WriteAllBytes("$PWD\$($resource.Name).png", [Convert]::FromBase64String($resource.ImageData))

    Save the image of resource 3 to a file

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/Get-TssInboxTemplateResource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/Get-TssInboxTemplateResource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Inbox.TemplateResource')]
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
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssInboxTemplateResource request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Inbox.TemplateResource](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Inbox.TemplateResource]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
