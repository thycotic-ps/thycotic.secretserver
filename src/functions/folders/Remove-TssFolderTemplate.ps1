function Remove-TssFolderTemplate {
    <#
    .SYNOPSIS
    Remove the associated template on the folder

    .DESCRIPTION
    Remove the ability to create secrets based on the template on the folder. If no associated template exists on the folder then any template can be used.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssFolderTemplate -TssSession $session -Id 23 -Template 6001, 6003, 6036

    Removes Template 6001 from Folder ID 23

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Remove-TssFolderTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Remove-TssFolderTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderId')]
        [int]
        $Id,

        # Template ID to associated
        [Parameter(ValueFromPipelineByPropertyName)]
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
                $uri = $TssSession.ApiUrl, 'folders', $Id, 'templates', $template -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                if ($PSCmdlet.ShouldProcess("FolderId: $folder", "$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue removing [$folder]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}