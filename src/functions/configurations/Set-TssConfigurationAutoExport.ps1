function Set-TssConfigurationAutoExport {
    <#
    .SYNOPSIS
    Set Automatic Export configuration

    .DESCRIPTION
    Set Automatic Export configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationAutoExport -TssSession $session -EnableAutoExport -ExportPath 'c:\temp\export'

    Enable Automatic Export, setting the needed configuration options

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationAutoExport -TssSession $session -TimeZone (Get-TimeZone).Id

    Set Secret Server Time Zone to the current user's Windows' default TimeZone.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationAutoExport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationAutoExport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Enable Automatic Export feature
        [switch]
        $Enable,

        # Export path, local path on Secret Server web node(s)
        [ValidateScript({ Test-Path $_ -IsValid })]
        [string]
        $Path,

        # Folder ID to export, pass in $null for All Folders
        [int]
        $FolderId,

        # Export All Folders
        [switch]
        $AllFolders,

        # Frequency (days)
        [ValidateRange(1,360)]
        [int]
        $Frequency,

        # Secret ID for export password
        [int]
        $SecretId,

        # Include Child folders on export
        [switch]
        $IncludeChildFolders,

        # Include Folder paths on export
        [switch]
        $IncludeFolderPaths,

        # Include TOTP settings
        [switch]
        $IncludeTotpSettings
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.0005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'auto-export' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{} }
            switch ($setParams.Keys) {
                'Enable' {
                    $enableIt = @{
                        dirty = $true
                        value = [boolean]$Enable
                    }
                    $setBody.Add('enable',$enableIt)
                }
                'Path' {
                    $setPath = @{
                        dirty = $true
                        value = $Path
                    }
                    $setBody.data.Add('exportPath',$setPath)
                }
                'FolderId' {
                    $setFolderId = @{
                        dirty = $true
                        value = $FolderId
                    }
                    $setBody.data.Add('folderId',$setFolderId)
                }
                'AllFolders' {
                    $setAllFolders = @{
                        dirty = $true
                        value = $null
                    }
                    $setBody.data.Add('folderId',$setAllFolders)
                }
                'Frequency' {
                    $setFrequency = @{
                        dirty = $true
                        value = $Frequency
                    }
                    $setBody.data.Add('frequencyDays',$setFrequency)
                }
                'SecretId' {
                    $setSecretId = @{
                        dirty = $true
                        value = $SecretId
                    }
                    $setBody.data.Add('exportPasswordSecretId',$setSecretId)
                }
                'IncludeChildFolders' {
                    $includeChildren = @{
                        dirty = $true
                        value = [boolean]$IncludeChildFolders
                    }
                    $setBody.Add('exportChildFolders',$includeChildren)
                }
                'IncludeFolderPaths' {
                    $includePaths = @{
                        dirty = $true
                        value = [boolean]$IncludeFolderPaths
                    }
                    $setBody.Add('exportFolderPaths',$includePaths)
                }
                'IncludeTotpSettings' {
                    $includeTotp = @{
                        dirty = $true
                        value = [boolean]$IncludeTotpSettings
                    }
                    $setBody.Add('exportTotpSettings',$includeTotp)
                }
            }
            $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100

            if ($PSCmdlet.ShouldProcess("Automatic Export Configuration", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting Automatic Export configuration"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose 'Automatic Export configuration updated successfully'
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}