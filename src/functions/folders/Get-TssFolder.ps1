function Get-TssFolder {
    <#
    .SYNOPSIS
    Get a folder from Secret Server

    .DESCRIPTION
    Get a folder(s) from Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 4

    Returns folder associated with the Folder ID, 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 93 -GetChildren

    Returns folder associated with the Folder ID, 93 and include child folders

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 93 -IncludeTemplate

    Returns folder associated with Folder ID, 93 and include Secret Templates associated with the folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -FolderPath '\ABC Company\Security'

    Returns folder that has a path of ABC Company\Security

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/folders/Get-TssFolder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/folders/Get-TssFolder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('Thycotic.PowerShell.Folders.Folder')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder ID to retrieve
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [Alias('FolderId')]
        [int[]]
        $Id,

        # Retrieve all child folders within the requested folder
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'id')]
        [Alias('GetAllChildren')]
        [switch]
        $GetChildren,

        # Include allowable Secret Templates of the requested folder
        [Parameter(ParameterSetName = 'filter')]
        [Parameter(ParameterSetName = 'id')]
        [Alias('IncludeAssociatedTemplates', 'IncludeTemplates')]
        [switch]
        $IncludeTemplate,

        # Get folder based on path (e.g. \Parent\child1\child2)
        [Parameter(ParameterSetName = 'path')]
        [string]
        $FolderPath
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

            if ($tssParams.ContainsKey('FolderPath')) {
                $pathLeaf = Split-Path $FolderPath -Leaf
                $folderFound = . $SearchFolders $TssSession $pathLeaf | Where-Object FolderPath -EQ $FolderPath
                $Id = $folderFound.Id
            }
            if ($tssParams.ContainsKey('Id') -or $Id) {
                foreach ($folder in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'folders', $folder -join '/'
                    $uri = $uri + '?' + "getAllChildren=$GetChildren" + '&' + "includeAssociatedTemplates=$IncludeTemplate"

                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'GET'

                    Write-Verbose "$($invokeParams.Method) $uri"
                    try {
                        $restResponse = . $InvokeApi @invokeParams
                    } catch {
                        Write-Warning "Issue getting folder [$folder]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Folders.Folder[]]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}