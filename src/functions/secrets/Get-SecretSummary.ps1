function Get-SecretSummary {
    <#
    .SYNOPSIS
    Get the summary of a secret

    .DESCRIPTION
    Get the summary of a secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretSummary -TssSession $session -Id 42

    Returns the summary information of Secret ID 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretSummary

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-SecretSummary.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretSummary')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id
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
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'summary' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting summary for Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if (-not $restResponse.lastPasswordChangeAttempt) {
                    $restResponse.lastPasswordChangeAttempt = [datetime]::MinValue
                }
                if (-not $restResponse.lastAccessed) {
                    $restResponse.lastAccessed = [datetime]::MinValue
                }
                if (-not $restResponse.createDate) {
                    $restResponse.createDate = [datetime]::MinValue
                }

                if ($restResponse) {
                    [TssSecretSummary]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}