function Invoke-TssPlatformSyncNow {
    <#
    .SYNOPSIS
    Start a Platform synchronization now

    .DESCRIPTION
    Start a synchronization that updates Platform user properties and group memberships in Secret Server. Returns True when the run was started, not when it finished; follow it with Get-TssPlatformSync.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssPlatformSyncNow -TssSession $session
    Get-TssPlatformSync -TssSession $session

    Start a Platform synchronization and check its status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform/Invoke-TssPlatformSyncNow

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform/Invoke-TssPlatformSyncNow.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'platform', 'synchronization-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Platform synchronization", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssPlatformSyncNow request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
