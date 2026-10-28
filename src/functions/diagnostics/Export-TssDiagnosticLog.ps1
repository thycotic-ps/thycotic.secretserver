function Export-TssDiagnosticLog {
    <#
    .SYNOPSIS
    Export the Secret Server logs to a zip file

    .DESCRIPTION
    Downloads the zip file of the Secret Server logs, the same as the Export Logs button under Admin, Diagnostics, and writes it to the Output folder as ThycoticSecretServerLogs_<yyyyMMdd-HHmmss>.zip.
    Returns the file. Requires the Administer Configuration or View Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Output
    Folder the zip file is written to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssDiagnosticLog -TssSession $session -Output C:\export

    Download the logs zip file to C:\export

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Export-TssDiagnosticLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Export-TssDiagnosticLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding()]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'diagnostics', 'export-logs' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Export-TssDiagnosticLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($apiResponse.IsSuccessful -and $apiResponse.RawBytes) {
                $fileName = 'ThycoticSecretServerLogs_{0:yyyyMMdd-HHmmss}.zip' -f (Get-Date)
                $outFile = [System.IO.Path]::Combine((Resolve-Path -LiteralPath $Output).ProviderPath, $fileName)
                [System.IO.File]::WriteAllBytes($outFile, $apiResponse.RawBytes)
                Get-Item -LiteralPath $outFile
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
