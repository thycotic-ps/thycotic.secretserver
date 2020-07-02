function Find-TssSecret {
    [cmdletbinding(DefaultParameterSetName="filter")]
    param(
        # Return only secrets within a certain folder
        [Parameter(ParameterSetName="filter")]
        [int[]]
        $FolderId,

        # Return only secrets matching a certain template
        [Parameter(ParameterSetName="filter")]
        [int[]]
        $TemplateId,

        # Return only secrets within a certain site
        [Parameter(ParameterSetName="filter")]
        [int[]]
        $SiteId,

        # Whether to include inactive secrets in results
        [Parameter(ParameterSetName="filter")]
        [switch]
        $IncludeInactive,

        # Whether to include active secrets in results (when excluded equals true)
        [Parameter(ParameterSetName="filter")]
        [switch]
        $IncludeActive,

        # Return only secrets with a certain heartbeat status
        [Parameter(ParameterSetName="filter")]
        [ValidateSet('Success','Failed','UnableToConnect','IncompatibleHost','UnknownError')]
        [string]
        $HeartbeatStatus,

        [Parameter(ParameterSetName="field")]
        [string]
        $SearchField,

        # Search text value for field
        [Parameter(ParameterSetName="field")]
        [string]
        $SearchText,

        # Field-slug to search. This will override SearchField.
        [Parameter(ParameterSetName="field")]
        [string]
        $SearchSlug,

        # output the raw response from the API endpoint
        [Parameter(ParameterSetName="filter")]
        [Parameter(ParameterSetName="field")]
        [switch]
        $Raw
    )
    begin {
        $invokeParams = @{}

        $Parameters = @{} + $PSBoundParameters
        $Parameters.Remove('Raw')
        $filterParams = . $GetFindSecretParams $Parameters
    }

    process {
        . $TestTssSession -Session

        $uri = $TssSession.SecretServerUrl, $TssSession.ApiVersion, "secrets" -join '/'

        $filters = $filterParams.GetEnumerator() | ForEach-Object { "filter.$($_.name)=$($_.value)" }
        $uriFilter = $filters -join "&"

        $invokeParams.Uri = ($Uri,$uriFilter -join "?")
        $invokeParams.PersonalAccessToken = $TssSession.AuthToken
        $invokeParams.Method = 'GET'
        if (-not $Raw) {
            $invokeParams.ExpandProperty = 'records'
        }

        Invoke-TssRestApi @invokeParams
    }
}