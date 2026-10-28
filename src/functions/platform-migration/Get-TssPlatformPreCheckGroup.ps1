function Get-TssPlatformPreCheckGroup {
    <#
    .SYNOPSIS
    Get the group pre-check summary for a Platform migration

    .DESCRIPTION
    Get the result of the pre-check Secret Server runs on its groups before they migrate to the Delinea Platform: error, warning and information counts, whether any group has an empty group type, and the errors found.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformPreCheckGroup -TssSession $session | Select-Object -ExpandProperty Errors

    List the errors the group pre-check found

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-migration/Get-TssPlatformPreCheckGroup

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-migration/Get-TssPlatformPreCheckGroup.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires Platform integration: a Secret Server without it answers 500 API_PlatformNotEnabled.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformMigration.PreCheckSummary')]
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
            $uri = $TssSession.ApiUrl, 'platform-migration', 'pre-check-groups' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformPreCheckGroup request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformMigration.PreCheckSummary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformMigration.PreCheckSummary]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
