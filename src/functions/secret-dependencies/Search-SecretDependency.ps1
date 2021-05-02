function Search-SecretDependency {
    <#
    .SYNOPSIS
    Return a list of Secret Dependencies for a Secret

    .DESCRIPTION
    Return a list of Secret Dependencies for a Secret

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Search-TssSecretDependency

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-dependencies/Search-SecretDependency.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretDependency -TssSession $session -Id 42

    Return Secret Dependencies configured for Secret ID 42

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretDependencySummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Dependency Group
        [int]
        $GroupId,

        # Include inactive/disabled Dependencies
        [switch]
        $IncludeInactive,

        # Filter on last run status, allowed Success, Failed, NotRun
        [ValidateSet('Success','Failed','NotRun')]
        [string]
        $LastRunStatus,

        # Search Text in title (or name) and machine fields
        [string]
        $SearchText,

        # Filter based on Dependency Template Id
        [int]
        $TemplateId,

        # Sort by specific property, default Id
        [string]
        $SortBy = 'Id'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-dependencies' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

                $filters = @()
                $filters += "filter.secretId=$secret"
                switch ($tssParams.Keys) {
                    'GroupId' { $filters += "filter.groupId=$GroupId" }
                    'IncludeInactive' { $filters += "filter.includeInactive=$([boolean]$IncludeInactive)" }
                    'LastRunStatus' { $filters += "filter.lastRunStatus=$LastRunStatus" }
                    'TemplateId' { $filters += "filter.templateId=$TemplateId" }
                    'SearchText' { $filters += "filter.searchText=$SearchText" }
                }
                if ($filters) {
                    $uriFilter = $filters -join '&'
                    Write-Verbose "Filters: $uriFilter"
                    $uri = $uri, $uriFilter -join '&'
                }

                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue on search request"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                    Write-Warning "No Secret Dependencies found on Secret [$secret]"
                }
                if ($restResponse.records) {
                    [TssSecretDependencySummary[]]$restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}