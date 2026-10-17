function Set-TssDistributedEngineLatestVersion {
    <#
    .SYNOPSIS
    Refresh the latest Distributed Engine version stored in the Distributed Engine configuration

    .DESCRIPTION
    Reads the latest Distributed Engine version file on the Secret Server web server and, when that version is allowed and not lower than the minimum required engine version, stores it as the latest version in the Distributed Engine configuration.
    When automatic engine updates are on (autoUpdateEnginesVersion), it also makes that version the minimum required engine version.
    Takes no input. LatestVersion in the result is the minimum required engine version, not the stored latest version: with automatic updates off it stays the same, so read latestDistributedEnginesVersion from Get-TssDistributedEngineConfiguration for the latest version.
    An empty LatestVersion means the request failed on the server; the Secret Server log has the reason.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDistributedEngineLatestVersion -TssSession $session
    (Get-TssDistributedEngineConfiguration -TssSession $session).latestDistributedEnginesVersion

    Refreshes the latest engine version in the Distributed Engine configuration, then reads the stored latest version

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Set-TssDistributedEngineLatestVersion

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Set-TssDistributedEngineLatestVersion.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineLatestVersion')]
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
            Compare-TssVersion $TssSession '11.6.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'configuration', 'engine-latest-version' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            if ($PSCmdlet.ShouldProcess("Distributed engine latest version", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDistributedEngineLatestVersion request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DistributedEngines.EngineLatestVersion](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.EngineLatestVersion]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
