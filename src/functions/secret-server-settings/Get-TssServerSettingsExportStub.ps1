function Get-TssServerSettingsExportStub {
    <#
    .SYNOPSIS
    Get an empty Secret Server settings template

    .DESCRIPTION
    Returns the settings export shape with every section empty. Nothing is read from the server: the instance ID is all zeros and the configuration version is blank. Use Export-TssServerSettings for the real values.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssServerSettingsExportStub -TssSession $session

    Returns the empty settings template

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-server-settings/Get-TssServerSettingsExportStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-server-settings/Get-TssServerSettingsExportStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretServerSettings.Settings')]
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
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secretserversettings', 'export', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssServerSettingsExportStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretServerSettings.Settings](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretServerSettings.Settings]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
