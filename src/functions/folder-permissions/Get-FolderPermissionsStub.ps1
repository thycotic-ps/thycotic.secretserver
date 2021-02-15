﻿function Get-FolderPermissionsStub {
    <#
    .SYNOPSIS
    Get default values for a new folder permission

    .DESCRIPTION
    Get default values for a new folder permission, a template object

    .EXAMPLE
    PS> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS> Get-TssFolderPermissionsStub -TssSession $session -FolderId 36

    Return template object of a new folder permission

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssFolderPermission')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [int]
        $FolderId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $restResponse = $null
            $uri = $TssSession.ApiUrl, "folder-permissions/stub?folderId=$FolderId" -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            $invokeParams.PersonalAccessToken = $TssSession.AccessToken
            Write-Verbose "$($invokeParams.Method) $uri"
            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue getting folder permission stub on [$folder]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [TssFolderPermission]@{
                    FolderAccessRoleId = $restResponse.folderAccessRoleId
                    GroupId            = $restResponse.groupId
                    SecretAccessRole   = $restResponse.secretAccessRoleId
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}