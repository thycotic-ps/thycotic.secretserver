function Clear-TssQuartzJobError {
    <#
    .SYNOPSIS
    Clear the errors of the scheduled background jobs

    .DESCRIPTION
    Resets the Quartz scheduler triggers that are in error so the background jobs run again, the same as the Clear Quartz Job Errors button under Admin, Diagnostics.
    Returns True when the errors were cleared. Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Clear-TssQuartzJobError -TssSession $session

    Clear the errors of the scheduled background jobs

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Clear-TssQuartzJobError

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Clear-TssQuartzJobError.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'clear-quartz-job-errors' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Quartz job error", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Clear-TssQuartzJobError request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
