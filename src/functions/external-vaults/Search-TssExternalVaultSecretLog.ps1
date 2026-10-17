function Search-TssExternalVaultSecretLog {
    <#
    .SYNOPSIS
    Search the log of an external vault secret

    .DESCRIPTION
    Search the log entries of an external vault secret, such as push, pull and sync requests and their results.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    External vault secret ID

    .PARAMETER LogLevel
    Only return log entries with these log levels (numeric, as in the LogLevel property of the output)

    .PARAMETER SearchText
    Filter on log message text

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultSecretLog -TssSession $session -Id 12

    Get the log entries of external vault secret 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssExternalVaultSecretLog -TssSession $session -Id 12 -SearchText 'Push'

    Get the log entries of external vault secret 12 that mention Push

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/external-vaults/Search-TssExternalVaultSecretLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/external-vaults/Search-TssExternalVaultSecretLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.ExternalVaults.Log[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ExternalVaultSecretId')]
        [int[]]
        $Id,

        [int[]]
        $LogLevel,

        [string]
        $SearchText
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'external-vaults', 'vaults', 'secrets', $currentId, 'logs' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                switch ($tssParams.Keys) {
                    'LogLevel' {
                        foreach ($queryValue in $LogLevel) {
                            $queryParams += "filter.logLevel=$($queryValue)"
                        }
                    }
                    'SearchText' {
                        $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                    }
                }
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssExternalVaultSecretLog request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.ExternalVaults.Log[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.ExternalVaults.Log]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
