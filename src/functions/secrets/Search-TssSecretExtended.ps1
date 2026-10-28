function Search-TssSecretExtended {
    <#
    .SYNOPSIS
    Get extended search details for secrets

    .DESCRIPTION
    Returns, for each secret ID, whether the secret has launchers, whether it is a favorite, its total views and when it was last accessed.
    Use it to add these details to Search-TssSecret results.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretId
    Secret IDs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretExtended -TssSession $session -SecretId (Search-TssSecret -TssSession $session -FolderId 7).Id

    Returns the extended details of the secrets in folder 7

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretExtended

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretExtended.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.ExtendedSearchDetail[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('SecretIds')]
        [int[]]
        $SecretId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrets', 'extended-search-details' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'SecretId' {
                    $body.data.Add('secretIds', $SecretId)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssSecretExtended request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Secrets.ExtendedSearchDetail[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ExtendedSearchDetail]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
