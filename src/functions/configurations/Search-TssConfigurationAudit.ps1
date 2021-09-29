function Search-TssConfigurationAudit {
    <#
    .SYNOPSIS
    Search system configuration audit

    .DESCRIPTION
    Search system configuration audit, latest record first

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssConfigurationAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssConfigurationAudit.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssConfigurationAudit -TssSession $session -SearchText admin

    Return audit records containing "admin" in any of the properties

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssConfigurationAudit -TssSession $session | Select-Object -First 25

    Return 25 latest audit entries for Secret Server configuration

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.Audit')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Search text
        [Alias("")]
        [string]
        $SearchText,

        # Sort by specific property, default Date
        [string]
        $SortBy = 'Date'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration','audit' -join '/'
            $uri = $uri, "sortBy[0].direction=desc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'SearchText' { $filters += "filter.searchTerm=$SearchText" }
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No ConfigurationAudit found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Configuration.Audit[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}