function Start-TssSecretErase {
    <#
    .SYNOPSIS
    Run approved secret erase requests now

    .DESCRIPTION
    Processes the approved secret erase requests whose EraseAfter date has passed, instead of waiting for the scheduled run. The secrets are permanently erased.
    Returns True or False.
    Secret Server returns an error when the Secret Erase feature is not enabled.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssSecretErase -TssSession $session -Confirm:$false

    Runs the approved secret erase requests that are due

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-erase-requests/Start-TssSecretErase

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-erase-requests/Start-TssSecretErase.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'secret-erase-requests', 'run-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            if ($PSCmdlet.ShouldProcess("Secret erase", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssSecretErase request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [boolean]::Parse("$restResponse")
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
