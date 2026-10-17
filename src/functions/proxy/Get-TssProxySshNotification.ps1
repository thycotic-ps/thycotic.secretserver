function Get-TssProxySshNotification {
    <#
    .SYNOPSIS
    Get the SSH proxy status message

    .DESCRIPTION
    Returns the SSH proxy status text Secret Server shows, for example how many sites and engines run the SSH proxy and any warning.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssProxySshNotification -TssSession $session

    Returns the SSH proxy status text

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/proxy/Get-TssProxySshNotification

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/proxy/Get-TssProxySshNotification.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
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
            $uri = $TssSession.ApiUrl, 'proxy', 'ssh', 'notification' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssProxySshNotification request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                $restResponse | ConvertFrom-Json
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
