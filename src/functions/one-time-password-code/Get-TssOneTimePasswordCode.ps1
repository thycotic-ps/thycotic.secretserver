function Get-TssOneTimePasswordCode {
    <#
    .SYNOPSIS
    Get one-time password codes for a secret

    .DESCRIPTION
    Get the current one-time password (TOTP) code of a secret with one-time password enabled, and the seconds it stays valid.
    Secret Server returns only the current code, whatever NumberOfCodesToGenerate is set to.
    The output is credential material.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER NumberOfCodesToGenerate
    Number of codes to request. Secret Server ignores it and returns only the current code

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssOneTimePasswordCode -TssSession $session -Id 42

    Returns the current one-time password code of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/one-time-password-code/Get-TssOneTimePasswordCode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/one-time-password-code/Get-TssOneTimePasswordCode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.OneTimePasswordCode.OneTimePassword[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [int]
        $NumberOfCodesToGenerate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'one-time-password-code', $currentId -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'NumberOfCodesToGenerate' {
                        $queryParams += "numberOfCodesToGenerate=$($NumberOfCodesToGenerate)"
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
                    Write-Warning 'Issue with Get-TssOneTimePasswordCode request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.OneTimePasswordCode.OneTimePassword[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.OneTimePasswordCode.OneTimePassword]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
