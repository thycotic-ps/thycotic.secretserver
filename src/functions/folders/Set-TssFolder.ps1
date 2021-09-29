function Set-TssFolder {
    <#
    .SYNOPSIS
    Set various properties for a given secret folder

    .DESCRIPTION
    Set various properties for a given secret folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolder -TssSession $session -FolderId 93 -FolderName 'Security Admins'

    Renames Folder ID 93 to 'Security Admins'

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderId')]
        [int[]]
        $Id,

        # Allowed templates
        [Parameter(ParameterSetName = 'templates')]
        [Alias('AllowedTemplates')]
        [int[]]
        $AllowedTemplate,

        # Allow remove owner
        [switch]
        $AllowRemoveOwner,

        # Enable inherit permissions
        [Alias('EnableInheritPermissions')]
        [switch]
        $EnableInheritPermission,

        # Enable Inherit Secret Policy
        [switch]
        $EnableInheritSecretPolicy,

        # Folder name
        [string]
        $FolderName,

        # Secret Policy
        [int]
        $SecretPolicy
    )
    begin {
        $setFolderParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setFolderParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($folder in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folder', $folder -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PATCH'

                $setFolderBody = @{ data = @{ } }

                $whatIfProcessing = 0
                switch ($setFolderParams.Keys) {
                    'AllowedTemplate' {
                        if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "Updating AutoChangeNextPassword to $($AllowedTemplate)")) {
                            $whatIfProcessing++
                        }
                        if ($setFolderParams.ContainsKey('EnableInheritPermission') -and $EnableInheritPermission) {
                            Write-Warning "Unable to update allowed templates when enabling Inherit Permissions on folder [$folder]"
                        }
                        $setFolderBody.data.allowedTemplates = [string[]]$AllowedTemplate
                    }
                    'AllowRemoveOwner' {
                        if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "Updating AllowRemoveOwner to $AllowRemoveOwner")) {
                            $whatIfProcessing++
                        }
                        $setFolderBody.data.allowRemoveOwner = "$AllowRemoveOwner"
                    }
                    'EnableInheritPermission' {
                        if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "Updating EnableInheritPermission to $EnableInheritPermission")) {
                            $whatIfProcessing++
                        }
                        $setFolderBody.data.enableInheritPermissions = @{
                            dirty = $true
                            value = $EnableInheritPermission
                        }
                    }
                    'EnableInheritSecretPolicy' {
                        if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "Updating EnableInheritSecretPolicy to $EnableInheritSecretPolicy")) {
                            $whatIfProcessing++
                        }
                        $setFolderBody.data.enableInheritSecretPolicy = @{
                            dirty = $true
                            value = $EnableInheritSecretPolicy
                        }
                    }
                    'FolderName' {
                        if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "Updating FolderName to $FolderName")) {
                            $whatIfProcessing++
                        }
                        $setFolderBody.data.folderName = @{
                            dirty = $true
                            value = $FolderName
                        }
                    }
                    'SecretPolicy' {
                        if (-not $PSCmdlet.ShouldProcess("FolderId: $folder", "Updating SecretPolicy to $SecretPolicy")) {
                            $whatIfProcessing++
                        }
                        if ($setFolderParams.ContainsKey('EnableInheritSecretPolicy') -and $EnableInheritSecretPolicy) {
                            Write-Warning "Unable to set Secret Policy when enabling Secret Policy Inheritance on folder [$folder]"
                        }

                        $setFolderBody.data.secretPolicy = @{
                            dirty = $true
                            value = $SecretPolicy
                        }
                    }
                }

                $invokeParams.Body = $setFolderBody | ConvertTo-Json

                if ($PSCmdlet.ShouldProcess("FolderID: $folder", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting property on folder [$folder]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                }
                Write-Verbose "Raw output from endpoint: $restResponse"
                if ($restResponse) {
                    if ($setFolderParams.ContainsKey('AllowedTemplate') -and $restResponse.allowedTemplates) {
                        $compareAllowed = Compare-Object -ReferenceObject $AllowedTemplate -DifferenceObject $restResponse.allowedTemplates -PassThru
                        if ($compareAllowed) {
                            Write-Warning "Unable to set AllowedTemplate for TemplateId [$compareAllowed] on folder [$folder]"
                        } else {
                            Write-Verbose "Folder [$folder] AllowedTemplate was set to $($AllowedTemplate)"
                        }
                    }
                    if ($setFolderParams.ContainsKey('AllowRemoveOwner')) {
                        Write-Verbose "Folder [$folder] set AllowRemoveOwner to $($AllowRemoveOwner)"
                    }
                    if ($setFolderParams.ContainsKey('EnableInheritPermission') -and $restResponse.EnableInheritPermission) {
                        Write-Verbose "Folder [$folder] set Inherit Permission to $($EnableInheritPermission)"
                    }
                    if ($setFolderParams.ContainsKey('EnableInheritSecretPolicy') -and $restResponse.EnableInheritSecretPolicy) {
                        Write-Verbose "Folder [$folder] set Secret Policy to $(if ($EnableInheritPermission) {'Inherit Secret Policy'} else {'No Secret Policy'})"
                    }
                    if ($setFolderParams.ContainsKey('FolderName') -and $restResponse.FolderName) {
                        if ($restResponse.folderName -eq $FolderName) {
                            Write-Verbose "Folder [$folder] set Folder Name to $FolderName"
                        }
                    }
                    if ($setFolderParams.ContainsKey('SecretPolicy') -and $restResponse.SecretPolicy) {
                        if ($restResponse.folderName -eq $FolderName) {
                            Write-Verbose "Folder [$folder] set Folder Name to $FolderName"
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}