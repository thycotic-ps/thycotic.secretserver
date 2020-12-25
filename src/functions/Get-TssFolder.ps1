﻿function Get-TssFolder {
    <#
    .SYNOPSIS
    Get a folder from Secret Server

    .DESCRIPTION
    Get a folder(s) from Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Id
    Folder ID to retrieve, accepts an array of IDs

    .PARAMETER Recurse
    Retrieve all child folders within the requested folder

    .PARAMETER IncludeTempaltes
    Include allowable Secret Templates of the requested folder

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('TssFolder')]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Return only specific Secret, Secret Id
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("FolderId")]
        [int[]]
        $Id,

        # get all children folders
        [Parameter(ParameterSetName = 'filter')]
        [Alias("GetAllChildren")]
        [switch]
        $Recurse,

        # Get associated templates
        [Parameter(ParameterSetName = 'filter')]
        [Alias("IncludeAssociatedTemplates")]
        [switch]
        $IncludeTemplates,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssFolder'
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($folder in $Id) {
                $restResponse = $null
                $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "folders", $folder.ToString() -join '/')
                $uri = $uri + '?' + "getAllChildren=$Recurse" + "&" + "includeAssociatedTemplates=$IncludeTemplates"

                $invokeParams.Uri = $Uri
                $invokeParams.Method = 'GET'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                $restResponse = Invoke-TssRestApi @invokeParams

                if ($tssParams['Raw']) {
                    return $restResponse
                }
                if ($restResponse) {
                    . $GetTssFolderObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}