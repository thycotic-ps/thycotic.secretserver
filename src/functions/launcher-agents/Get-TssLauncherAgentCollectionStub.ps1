function Get-TssLauncherAgentCollectionStub {
    <#
    .SYNOPSIS
    Get a launcher agent collection stub

    .DESCRIPTION
    Get an empty launcher agent collection with the server defaults, to fill in before New-TssLauncherAgentCollection.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $stub = Get-TssLauncherAgentCollectionStub -TssSession $session
    New-TssLauncherAgentCollection -TssSession $session -Name 'Jump hosts' -RecordKeystrokes:$stub.RecordKeystrokes -RecordStandaloneSessions:$stub.RecordStandaloneSessions

    Create a collection with the server default recording settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollectionStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollectionStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Collection')]
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
            $uri = $TssSession.ApiUrl, 'launcheragents', 'collections', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssLauncherAgentCollectionStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.LauncherAgents.Collection](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.Collection]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
