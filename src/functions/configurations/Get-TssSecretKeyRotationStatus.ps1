function Get-TssSecretKeyRotationStatus {
    <#
    .SYNOPSIS
    Get the status of the secret key rotation

    .DESCRIPTION
    Returns when a Rotate Secret Keys run was last requested and last ran, its last status, and the progress of the current run (secrets processed, total, cancelling).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretKeyRotationStatus -TssSession $session

    Returns the secret key rotation status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSecretKeyRotationStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSecretKeyRotationStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SecretKeyRotationStatus')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'security', 'rotate-secret-keys-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretKeyRotationStatus request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.SecretKeyRotationStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SecretKeyRotationStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
