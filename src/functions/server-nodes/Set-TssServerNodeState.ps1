function Set-TssServerNodeState {
    <#
    .SYNOPSIS
    Turn clustering on or off

    .DESCRIPTION
    Turns clustering on or off for the Secret Server installation.
    Returns the new state, including RequiresRestart when the web nodes must restart for the change to apply.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnableClustering
    Enable clustering

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssServerNodeState -TssSession $session -EnableClustering

    Turns on clustering after confirmation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssServerNodeState -TssSession $session -EnableClustering:$false -WhatIf

    Shows the request that would turn off clustering, without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/server-nodes/Set-TssServerNodeState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/server-nodes/Set-TssServerNodeState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Changes server-wide state and may recycle the web application, so it asks for confirmation by default.

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.ServerNodes.StateUpdate')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EnableClustering
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.7.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'nodes-state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EnableClustering' {
                    $body.data.Add('enableClustering', @{ dirty = $true; value = [boolean]$EnableClustering })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Server node state", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssServerNodeState request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.ServerNodes.StateUpdate](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.ServerNodes.StateUpdate]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
