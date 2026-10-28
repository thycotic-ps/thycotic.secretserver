function New-TssInboxTemplateResource {
    <#
    .SYNOPSIS
    Upload an image for inbox notification templates

    .DESCRIPTION
    Uploads a PNG or JPG image as an embedded inbox template resource, so inbox notification templates can reference it by its slug.
    The slug may only contain lower-case letters and hyphens, and must not already be in use: to replace an image, remove the old resource with Remove-TssInboxTemplateResource first.
    The server checks the file content and rejects anything that is not a PNG or JPG image.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Slug
    Name templates use to reference the image: lower-case letters and hyphens only

    .PARAMETER Path
    Path of the PNG or JPG file to upload

    .PARAMETER FileName
    File name to send with the image, the file name of -Path when omitted

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxTemplateResource -TssSession $session -Slug company-logo -Path .\logo.png

    Upload logo.png as the resource company-logo

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssInboxTemplateResource -TssSession $session -Slug banner -Path .\banner.jpg -WhatIf

    Show the upload without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/inbox/New-TssInboxTemplateResource

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/inbox/New-TssInboxTemplateResource.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidatePattern('^[a-z-]+$', Options = 'None')]
        [string]
        $Slug,

        [Parameter(Mandatory)]
        [string]
        $Path,

        [string]
        $FileName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'inbox', 'templates', 'resources' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $restResponse = $null
            $filePath = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).ProviderPath
            $sendName = if ($tssParams.ContainsKey('FileName')) { $FileName } else { Split-Path -Path $filePath -Leaf }
            $invokeParams.Body = @{
                slug           = $Slug
                fileName       = $sendName
                fileAttachment = [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes($filePath))
            } | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Inbox template resource: $Slug", "$($invokeParams.Method) $uri with file $sendName")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with slug $Slug and file $sendName"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssInboxTemplateResource request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
