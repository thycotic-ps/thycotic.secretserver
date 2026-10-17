function Start-TssAutoExport {
    <#
    .SYNOPSIS
    Run the automatic export now

    .DESCRIPTION
    Starts the automatic export now, using the current automatic export configuration (see Get-TssConfigurationAutoExport).
    Returns True when Secret Server queued the export. When automatic export is disabled Secret Server refuses the request with HTTP 500 and errorCode API_ConfigurationNotEnabled: the cmdlet writes an error, returns nothing and no export runs. On-prem the error text is API_ConfigurationNotEnabled; on Secret Server Cloud it can read only Internal Server Error. Enable it first with Set-TssConfigurationAutoExport -Enable.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssAutoExport -TssSession $session

    Run the automatic export now

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Start-TssAutoExport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Start-TssAutoExport.ps1

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
            $uri = $TssSession.ApiUrl, 'configuration', 'auto-export', 'run-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Auto export", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssAutoExport request'
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
