function Get-TssFolder {
    <#
    .SYNOPSIS
    Get a folder from Secret Server

    .DESCRIPTION
    Get a folder(s) from Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 4

    Returns the folder object for Folder ID, 4

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 93 -GetChildren

    Returns the folder object for Folder ID 93, including the child folder details

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 93,34 -IncludeTemplate

    Returns the folder object for Folder ID 93 and 94, including the Secret Templates associated with each folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -FolderPath '\ABC Company\Security'

    Returns the folder object for the Security folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -FolderPath '\ABC Company\Security', 'ABC Company\Vendors'

    Returns the folder object for the Security and Vendors folder

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

        # Folder Path, will retrieve the leaf level folder (see examples)
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'filter')]
        [string[]]
        $FolderPath,

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
        $IncludeTemplate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            if ($tssParams.ContainsKey('FolderPath')) {
                Compare-TssVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
                foreach ($path in $FolderPath) {
                    $uri = $TssSession.ApiUrl, 'folders', 0 -join '/'
                    $uri = $uri, "folderPath=$path&getAllChildren=$([boolean]$GetChildren)&includeAssociatedTemplates=$([boolean]$IncludeTemplate)" -join '?'

                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'GET'

                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting folder [$path]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Folders.Folder[]]$restResponse
                    }
                }
            }
            if ($tssParams.ContainsKey('Id') -or $Id) {
                Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
                foreach ($folder in $Id) {
                    $uri = $TssSession.ApiUrl, 'folders', $folder -join '/'
                    $uri = $uri, "getAllChildren=$([boolean]$GetChildren)&includeAssociatedTemplates=$([boolean]$IncludeTemplate)" -join '?'

                    $invokeParams.Uri = $Uri
                    $invokeParams.Method = 'GET'

                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
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