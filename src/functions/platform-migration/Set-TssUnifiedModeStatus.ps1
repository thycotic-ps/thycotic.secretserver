function Set-TssUnifiedModeStatus {
    <#
    .SYNOPSIS
    Set the Platform unified mode status

    .DESCRIPTION
    Set the unified mode status recorded for the Platform migration, for example to clear a stale InProgress status. Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Status
    New status: NotStarted, Started, InProgress, Completed, CompletedWithErrors or UnresolvedError

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssUnifiedModeStatus -TssSession $session -Status NotStarted

    Reset the unified mode status to NotStarted

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Set-TssUnifiedModeStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Set-TssUnifiedModeStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PlatformMigration.OperationResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateSet('NotStarted', 'Started', 'InProgress', 'Completed', 'CompletedWithErrors', 'UnresolvedError')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'platform-migration', 'update-unified-mode-status' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Status' {
                    $body.data.Add('status', $Status)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Unified mode status", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssUnifiedModeStatus request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PlatformMigration.OperationResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.OperationResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
