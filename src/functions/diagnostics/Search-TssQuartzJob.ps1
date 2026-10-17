function Search-TssQuartzJob {
    <#
    .SYNOPSIS
    List the scheduled background jobs

    .DESCRIPTION
    Lists the Quartz scheduler triggers shown under Admin, Diagnostics: one entry per scheduled background job with its trigger state and its previous and next fire times.
    Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssQuartzJob -TssSession $session

    List the scheduled background jobs

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssQuartzJob -TssSession $session | Where-Object TriggerState -EQ 'ERROR'

    List the jobs whose trigger is in error

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssQuartzJob

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssQuartzJob.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.QuartzJob[]')]
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
            $uri = $TssSession.ApiUrl, 'diagnostics', 'quartz-jobs' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssQuartzJob request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Diagnostics.QuartzJob[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Diagnostics.QuartzJob]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
