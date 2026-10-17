function Restore-TssReport {
    <#
    .SYNOPSIS
    Restore a deleted system report

    .DESCRIPTION
    Restore (undelete) a deleted system report.
    Only system reports can be restored this way; a deleted custom report must be edited so its SQL is validated again.
    Returns True when the report was restored.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Report ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Restore-TssReport -TssSession $session -Id 60

    Restores deleted system report 60

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Restore-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Restore-TssReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportId')]
        [int[]]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', $currentId, 'undelete' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'
                if ($PSCmdlet.ShouldProcess("Report Id: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue restoring report [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($null -ne $restResponse) {
                        [boolean]$restResponse.success
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
