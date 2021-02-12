﻿function Remove-FolderTemplate {
    <#
    .SYNOPSIS
    Remove the associated template on the folder

    .DESCRIPTION
    Remove the ability to create secrets based on the template on the folder. If no associated template exists on the folder then any template can be used.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssFolderTemplate -TssSession $session -Id 23 -Template 6001, 6003, 6036

    Removes Template 6001 from Folder ID 23

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('TssDelete')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("FolderId")]
        [int]
        $Id,

        # Template ID to associated
        [Parameter(ValueFromPipelineByPropertyName)]
        [int[]]
        $TemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($template in $TemplateId) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folders', $Id, 'templates', $template -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                if (-not $PSCmdlet.ShouldProcess($folder,"$($invokeParams.Method) $uri")) { return }
                Write-Verbose "$($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue removing [$folder]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssDelete]@{
                        Id         = $restResponse.id
                        ObjectType = $restResponse.objectType
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}