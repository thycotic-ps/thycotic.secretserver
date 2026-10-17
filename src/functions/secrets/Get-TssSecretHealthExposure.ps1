function Get-TssSecretHealthExposure {
    <#
    .SYNOPSIS
    Get the users who viewed a secret since its last password change

    .DESCRIPTION
    Returns the secret exposure check: every user who viewed the secret since its password last changed, and whether each can still view it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretHealthExposure -TssSession $session -Id 42

    Returns the users who viewed secret 42 since its last password change

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretHealthExposure

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretHealthExposure.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.HealthExposure[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secrethealth', 'exposure' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            $queryParams += 'sortBy[0].direction=asc'
            $queryParams += 'sortBy[0].name=displayName'
            switch ($tssParams.Keys) {
                'Id' {
                    $queryParams += "filter.secretId=$($Id)"
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
                Write-Warning 'Issue with Get-TssSecretHealthExposure request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Secrets.HealthExposure[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Secrets.HealthExposure]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
