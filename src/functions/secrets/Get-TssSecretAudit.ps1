function Get-TssSecretAudit {
    <#
    .SYNOPSIS
    Get audits for a Secret(s)

    .DESCRIPTION
    Get audits for a Secret(s), data is sorted (server-side) in descending order (latest record comes first)

    .EXAMPLE
    PS> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS> Get-TssSecretAudit -TssSession $session -Id 65

    Get audit for Secret ID 65

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.Audit')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
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
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'audits' -join '/'
                $uri = $uri, "sortBy[0].direction=desc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'

                if ($tssParams.ContainsKey('IncludePasswordChangeLog')) {
                    $uri = $uri, "filter.includePasswordChangeLog=$([boolean]$IncludePasswordChangeLog)" -join '&'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting audits for [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.Audit[]]$restResponse.records
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}