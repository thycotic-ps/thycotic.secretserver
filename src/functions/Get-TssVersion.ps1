function Get-TssVersion {
    <#
    .SYNOPSIS
    Get version of Secret Server

    .DESCRIPTION
    Get the version of Secret Server

    .PARAMETER TssSession
    TssSession object created by New-TssSession

    .PARAMETER Raw
    Output the raw response from the REST API endpoint

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssVersion -TssSession $session

    Returns version of Secret Server alpha

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('System.String')]
    param(
        # TssSession object passed for auth info
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # output the raw response from the API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssVersion'
        $invokeParams = @{ }
    }

    process {
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            $uri = $TssSession.SecretServer + ($TssSession.ApiVersion, "version" -join '/')
            $invokeParams.Uri = $Uri
            $invokeParams.Method = 'GET'
            $invokeParams.PersonalAccessToken = $TssSession.AccessToken

            try {
                $restResponse = Invoke-TssRestApi @invokeParams
            } catch {
                Write-Warning "Issue reading version, verify Hide Secret Server Version Numbers is disabled in Secret Server"
                $err = $_.ErrorDetails.Message
                Write-Error $err
            }

            if ($tssParams['Raw']) {
                $restResponse
            }
            if ($restResponse) {
                . $GetTssVersionObject $restResponse
            }

        } else {
            Write-Warning "No valid session found"
        }
    }
}