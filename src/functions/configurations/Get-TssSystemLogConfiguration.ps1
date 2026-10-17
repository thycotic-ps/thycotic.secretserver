function Get-TssSystemLogConfiguration {
    <#
    .SYNOPSIS
    Get the system log configuration

    .DESCRIPTION
    Returns whether the system log is enabled, the maximum number of entries it keeps, whether administrators are notified when it is shrunk and whether log files can be viewed online.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSystemLogConfiguration -TssSession $session

    Returns the system log configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSystemLogConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSystemLogConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SystemLogConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'system-log' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSystemLogConfiguration request'
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
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
