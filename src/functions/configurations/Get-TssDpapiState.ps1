function Get-TssDpapiState {
    <#
    .SYNOPSIS
    Get the DPAPI encryption state

    .DESCRIPTION
    Get whether the Secret Server encryption key file is protected with the Windows Data Protection API or an HSM, and the path of that file on the web server.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDpapiState -TssSession $session

    Show whether the encryption key file is DPAPI or HSM protected

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssDpapiState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssDpapiState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only: Secret Server Cloud answers this endpoint with Access denied.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.DpapiState')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'dpapi', 'state' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDpapiState request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.DpapiState](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.DpapiState]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
