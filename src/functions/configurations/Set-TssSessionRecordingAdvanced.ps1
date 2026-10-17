function Set-TssSessionRecordingAdvanced {
    <#
    .SYNOPSIS
    Set the advanced session recording configuration

    .DESCRIPTION
    Updates the Advanced Session Recording settings. Only the parameters given are changed. Returns the updated configuration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AgentCallbackUrl
    URL the session recording agent sends its data to

    .PARAMETER EnableAdvancedSessionRecording
    Enable Advanced Session Recording; -EnableAdvancedSessionRecording:$false disables it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSessionRecordingAdvanced -TssSession $session -EnableAdvancedSessionRecording

    Enable Advanced Session Recording

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSessionRecordingAdvanced -TssSession $session -AgentCallbackUrl https://alpha/SecretServer

    Set the agent callback URL

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssSessionRecordingAdvanced

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssSessionRecordingAdvanced.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.SessionRecordingAdvanced')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $AgentCallbackUrl,

        [switch]
        $EnableAdvancedSessionRecording
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'sessionrecording-advanced' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AgentCallbackUrl' {
                    $body.data.Add('agentCallbackUrl', @{ dirty = $true; value = $AgentCallbackUrl })
                }
                'EnableAdvancedSessionRecording' {
                    $body.data.Add('enableAdvancedSessionRecording', @{ dirty = $true; value = [boolean]$EnableAdvancedSessionRecording })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Session recording advanced", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSessionRecordingAdvanced request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SessionRecordingAdvanced](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SessionRecordingAdvanced]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
