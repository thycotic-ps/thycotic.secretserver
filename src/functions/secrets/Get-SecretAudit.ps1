function Get-SecretAudit {
    <#
    .SYNOPSIS
    Get audits for a Secret(s)

    .DESCRIPTION
    Get audits for a Secret(s)

    .EXAMPLE
    PS> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS> Get-TssSecretAudit -TssSession $session -Id 65

    Get audit for Secret ID 65

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretAudit

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretAudit')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Include password changes in the results
        [switch]
        $IncludePasswordChangeLog,

        # Sort output, default to DateRecorded
        [string]
        $SortBy = 'DateRecorded'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
           . $CheckVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'audits' -join '/'
                $uri = $uri, "sortBy[0].direction=asc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

                if ($tssParams.ContainsKey('IncludePasswordChangeLog')) {
                    $uri = $uri, "filter.includePasswordChangeLog=$([boolean]$IncludePasswordChangeLog)" -join '&'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting audits for [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssSecretAudit[]]$restResponse.records
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}