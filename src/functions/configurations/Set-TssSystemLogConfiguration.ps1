function Set-TssSystemLogConfiguration {
    <#
    .SYNOPSIS
    Set the system log configuration

    .DESCRIPTION
    Updates the system log settings and returns the system log configuration. Only the parameters you pass are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AllowViewingOnline
    Allow viewing log files online. Use -AllowViewingOnline:$false to disallow it

    .PARAMETER EnableSystemLog
    Enable the system log. Use -EnableSystemLog:$false to disable it

    .PARAMETER MaxLogLength
    Maximum number of entries kept in the system log

    .PARAMETER NotifyWhenShrunk
    Notify administrators when the system log is shrunk. Use -NotifyWhenShrunk:$false to stop it

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSystemLogConfiguration -TssSession $session -MaxLogLength 50000 -NotifyWhenShrunk

    Keeps up to 50000 entries and notifies administrators when the log is shrunk

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssSystemLogConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssSystemLogConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.SystemLogConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $AllowViewingOnline,

        [switch]
        $EnableSystemLog,

        [int]
        $MaxLogLength,

        [switch]
        $NotifyWhenShrunk
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'system-log' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowViewingOnline' {
                    $body.data.Add('allowViewingOnline', @{ dirty = $true; value = [boolean]$AllowViewingOnline })
                }
                'EnableSystemLog' {
                    $body.data.Add('enableSystemLog', @{ dirty = $true; value = [boolean]$EnableSystemLog })
                }
                'MaxLogLength' {
                    $body.data.Add('maxLogLength', @{ dirty = $true; value = $MaxLogLength })
                }
                'NotifyWhenShrunk' {
                    $body.data.Add('notifyWhenShrunk', @{ dirty = $true; value = [boolean]$NotifyWhenShrunk })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("System log configuration", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSystemLogConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.SystemLogConfiguration]@{
                        AllowViewingOnline = $restResponse.allowViewingOnline.value
                        EnableSystemLog    = $restResponse.enableSystemLog.value
                        MaxLogLength       = $restResponse.maxLogLength.value
                        NotifyWhenShrunk   = $restResponse.notifyWhenShrunk.value
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
