function Save-TssManualUpgradePackage {
    <#
    .SYNOPSIS
    Download a generated manual upgrade file

    .DESCRIPTION
    Downloads a file generated during a manual (multi-step) upgrade and writes it to the -Output folder: the SQL script (UpgradeDeltas.sql, from New-TssManualUpgradeSqlScript) or the application ZIP (ManualUpgradeFiles-MM-DD-YYYY-version.zip, from New-TssManualUpgradeAppZip).
    Uses the binary download endpoint (api/v2) by default. -Base64 uses the older api/v1 endpoint, which returns the file base64 encoded in JSON, for servers without the api/v2 endpoint.
    The server accepts only those two file name shapes and fails the request for any other name. A file that was not generated yet returns an error (404 from api/v2) and writes nothing.
    Returns the saved file.
    Requires the Administer Configuration permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FileName
    File to download: UpgradeDeltas.sql, or the FileName returned by New-TssManualUpgradeAppZip

    .PARAMETER Output
    Folder to write the file to. The file keeps its name and an existing file of that name is overwritten

    .PARAMETER Base64
    Use the api/v1 endpoint, which returns the file base64 encoded in JSON

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Save-TssManualUpgradePackage -TssSession $session -FileName UpgradeDeltas.sql -Output .

    Downloads the generated SQL update script to the current folder

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $zip = New-TssManualUpgradeAppZip -TssSession $session
    Save-TssManualUpgradePackage -TssSession $session -FileName $zip.FileName -Output . -Base64

    Generates the application ZIP and downloads it through the api/v1 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/upgrade/Save-TssManualUpgradePackage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/upgrade/Save-TssManualUpgradePackage.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $FileName,

        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output,

        [Parameter(Mandatory, ParameterSetName = 'Base64')]
        [switch]
        $Base64
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'Base64' {
                    $uri = $TssSession.ApiUrl, 'upgrade', 'manual', 'download' -join '/'
                }
                default {
                    $uri = ($TssSession.ApiUrl -replace 'v1$','v2'), 'upgrade', 'manual', 'download' -join '/'
                }
            }
            $queryParams = @("fileName=$([uri]::EscapeDataString($FileName))")
            $uri = $uri, ($queryParams -join '&') -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            $outFile = [IO.Path]::Combine((Resolve-Path -LiteralPath $Output).ProviderPath, [IO.Path]::GetFileName($FileName))
            if ($PSCmdlet.ShouldProcess($outFile, "$($invokeParams.Method) $uri and write the file")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri [OutFile: $outFile]"
                $fileBytes = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    if ($PSCmdlet.ParameterSetName -eq 'Base64') {
                        $restResponse = . $ProcessResponse $apiResponse
                        if ($restResponse.fileRetrievalSuccess) {
                            $fileBytes = [Convert]::FromBase64String([string]$restResponse.file)
                        } elseif ($restResponse) {
                            Write-Error "Manual upgrade file [$FileName] not retrieved: $($restResponse.errorMessage)"
                        }
                    } elseif ($apiResponse.IsSuccessful -and $apiResponse.StatusCode -eq 200) {
                        $fileBytes = $apiResponse.RawBytes
                    } else {
                        $restResponse = . $ProcessResponse $apiResponse
                    }
                } catch {
                    Write-Warning 'Issue with Save-TssManualUpgradePackage request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $fileBytes) {
                    [IO.File]::WriteAllBytes($outFile, $fileBytes)
                    Get-Item -LiteralPath $outFile
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
