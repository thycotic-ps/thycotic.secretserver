function Get-TssPlatformSync {
    <#
    .SYNOPSIS
    Get the Platform synchronization status

    .DESCRIPTION
    Get the last and next Platform user and group synchronization: start, end and next run times, error count, groups created, membership changes and the last log entry. Returns nothing when no synchronization has run.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformSync -TssSession $session | Select-Object StartDateTime, EndDateTime, ErrorCount

    Show when the last Platform synchronization ran and its error count

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Get-TssPlatformSync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Get-TssPlatformSync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Platform.SyncStatus')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'synchronization' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformSync request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse -and $restResponse -ne 'null') {
                [Thycotic.PowerShell.Platform.SyncStatus](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Platform.SyncStatus]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
