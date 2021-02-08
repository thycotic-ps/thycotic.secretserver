function Get-Folder {
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
    Get-TssFolder -TssSession $session -Id 93 -Recurse

    Returns folder associated with the Folder ID, 93 and include child folders

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolder -TssSession $session -Id 93 -IncludeTemplates

    Returns folder associated with Folder ID, 93 and include Secret Templates associated with the folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssFolder

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('TssFolder')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Folder ID to retrieve
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("FolderId")]
        [int[]]
        $Id,

        # Retrieve all child folders within the requested folder
        [Parameter(ParameterSetName = 'filter')]
        [Alias("GetAllChildren")]
        [switch]
        $GetChildren,

        # Include allowable Secret Templates of the requested folder
        [Parameter(ParameterSetName = 'filter')]
        [Alias("IncludeAssociatedTemplates")]
        [switch]
        $IncludeTemplates
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($folder in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'folders', $folder.ToString() -join '/'
                $uri = $uri + '?' + "getAllChildren=$GetChildren" + "&" + "includeAssociatedTemplates=$IncludeTemplates"

                $invokeParams.Uri = $Uri
                $invokeParams.Method = 'GET'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting folder [$folder]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($restResponse) {
                    . $TssFolderObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}