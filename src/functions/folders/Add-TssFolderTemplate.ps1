function Add-TssFolderTemplate {
    <#
    .SYNOPSIS
    Associate a secret template with a folder

    .DESCRIPTION
    Allows secrets based on the template to be created in the folder.
    A folder with no associated templates allows any template. Once a template is associated, only secrets based on associated templates can be created in the folder.
    Use Remove-TssFolderTemplate to remove the association.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Folder ID

    .PARAMETER TemplateId
    Secret template ID to associate with the folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssFolderTemplate -TssSession $session -Id 23 -TemplateId 6001

    Allows secrets based on template 6001 in folder 23

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssFolderTemplate -TssSession $session -Id 23 -TemplateId 6001, 6003

    Allows secrets based on templates 6001 and 6003 in folder 23

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Add-TssFolderTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Add-TssFolderTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Folders.TemplateAssociation')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderId')]
        [int]
        $Id,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int[]]
        $TemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($template in $TemplateId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folders', $Id, 'templates' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $body = @{
                    folderId   = $Id
                    templateId = $template
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("FolderId: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue adding template [$template] to folder [$Id]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Folders.TemplateAssociation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Folders.TemplateAssociation]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
