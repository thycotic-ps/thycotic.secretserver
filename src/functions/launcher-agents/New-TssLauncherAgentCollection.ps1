function New-TssLauncherAgentCollection {
    <#
    .SYNOPSIS
    Create a launcher agent collection

    .DESCRIPTION
    Create an Advanced Session Recording launcher agent collection. The recording switches are always sent; an omitted switch is false.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Collection name

    .PARAMETER RecordKeystrokes
    Agents in the collection record keystroke data

    .PARAMETER RecordStandaloneSessions
    Agents in the collection record standalone (headless) sessions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssLauncherAgentCollection -TssSession $session -Name 'Jump hosts' -RecordKeystrokes

    Create a collection that records keystrokes but not standalone sessions

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/New-TssLauncherAgentCollection

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/New-TssLauncherAgentCollection.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.LauncherAgents.Collection')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [string]
        $Name,

        [switch]
        $RecordKeystrokes,

        [switch]
        $RecordStandaloneSessions
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'launcheragents', 'collections' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.Add('name', $Name)
                }
                'RecordKeystrokes' {
                    $body.Add('recordKeystrokes', [boolean]$RecordKeystrokes)
                }
                'RecordStandaloneSessions' {
                    $body.Add('recordStandaloneSessions', [boolean]$RecordStandaloneSessions)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Launcher agent collection", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssLauncherAgentCollection request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.LauncherAgents.Collection](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.Collection]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
