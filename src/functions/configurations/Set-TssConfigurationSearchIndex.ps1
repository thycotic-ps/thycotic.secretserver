function Set-TssConfigurationSearchIndex {
    <#
    .SYNOPSIS
    Set the secret search indexer configuration

    .DESCRIPTION
    Updates the secret search indexer settings and returns the indexer configuration. Only the parameters you pass are changed.
    Rebuild the index with Start-TssConfigurationSearchIndex.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER DaysToKeepLogs
    Days to keep the indexer logs

    .PARAMETER Enabled
    Enable the secret search indexer. Use -Enabled:$false to disable it

    .PARAMETER IndexingSeparators
    Characters that split field values into search terms

    .PARAMETER IndexMode
    Index mode

    .PARAMETER PreferFullTextWhenAvailable
    Prefer SQL Server full-text search when it is available

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationSearchIndex -TssSession $session -IndexMode Extended -DaysToKeepLogs 14

    Switches the indexer to extended mode and keeps its logs for 14 days

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationSearchIndex

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationSearchIndex.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.SearchIndexer')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $DaysToKeepLogs,

        [switch]
        $Enabled,

        [string[]]
        $IndexingSeparators,

        [ValidateSet('Standard', 'Extended')]
        [string]
        $IndexMode,

        [switch]
        $PreferFullTextWhenAvailable
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'secret-search-indexer' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'DaysToKeepLogs' {
                    $body.data.Add('daysToKeepLogs', @{ dirty = $true; value = $DaysToKeepLogs })
                }
                'Enabled' {
                    $body.data.Add('enabled', @{ dirty = $true; value = [boolean]$Enabled })
                }
                'IndexingSeparators' {
                    $body.data.Add('indexingSeparators', @{ dirty = $true; value = $IndexingSeparators })
                }
                'IndexMode' {
                    $body.data.Add('indexMode', @{ dirty = $true; value = $IndexMode })
                }
                'PreferFullTextWhenAvailable' {
                    $body.data.Add('preferFullTextWhenAvailable', @{ dirty = $true; value = [boolean]$PreferFullTextWhenAvailable })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration search index", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationSearchIndex request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SearchIndexer](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SearchIndexer]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
