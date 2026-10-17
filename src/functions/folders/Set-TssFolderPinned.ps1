function Set-TssFolderPinned {
    <#
    .SYNOPSIS
    Pin a folder or update its pin settings for the current user

    .DESCRIPTION
    Pins a folder for the current user, or updates the settings of an existing pin.
    Only the parameters provided are changed; a folder that is not pinned yet is pinned with the values given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Folder ID to pin or update

    .PARAMETER ActiveFilter
    Filter the pinned view to active secrets (true) or inactive secrets (false)

    .PARAMETER DisplayName
    Name of the pin, visible only to the current user, shown in the pinned folders list

    .PARAMETER IncludeSubfolders
    Include secrets in subfolders when browsing from the pin

    .PARAMETER SearchText
    Default search text for the pin

    .PARAMETER SelectedFolderId
    Folder to select in the tree when the pin is opened

    .PARAMETER ShowCards
    Show secrets as cards instead of a grid for this pin

    .PARAMETER TemplateFilter
    Secret template ID to filter the pinned view by

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderPinned -TssSession $session -Id 42

    Pins folder 42 for the current user

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssFolderPinned -TssSession $session -Id 42 -DisplayName 'Production servers' -ShowCards:$false -IncludeSubfolders

    Renames the pin on folder 42 and switches it to the grid view with subfolders included

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Set-TssFolderPinned

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Set-TssFolderPinned.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Folders.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FolderId')]
        [int]
        $Id,

        [switch]
        $ActiveFilter,

        [string]
        $DisplayName,

        [switch]
        $IncludeSubfolders,

        [string]
        $SearchText,

        [int]
        $SelectedFolderId,

        [switch]
        $ShowCards,

        [int]
        $TemplateFilter
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'folder', $Id, 'pinned' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'ActiveFilter' {
                    $body.data.Add('activeFilter', @{ dirty = $true; value = [boolean]$ActiveFilter })
                }
                'DisplayName' {
                    $body.data.Add('displayName', @{ dirty = $true; value = $DisplayName })
                }
                'IncludeSubfolders' {
                    $body.data.Add('includeSubfolders', @{ dirty = $true; value = [boolean]$IncludeSubfolders })
                }
                'SearchText' {
                    $body.data.Add('searchText', @{ dirty = $true; value = $SearchText })
                }
                'SelectedFolderId' {
                    $body.data.Add('selectedFolderId', @{ dirty = $true; value = $SelectedFolderId })
                }
                'ShowCards' {
                    $body.data.Add('showCards', @{ dirty = $true; value = [boolean]$ShowCards })
                }
                'TemplateFilter' {
                    $body.data.Add('templateFilter', @{ dirty = $true; value = $TemplateFilter })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Folder pinned: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssFolderPinned request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Folders.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Folders.ActionResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
