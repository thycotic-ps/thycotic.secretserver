function Get-TssDistributedEngineSiteConnectorDownload {
    <#
    .SYNOPSIS
    Download the MemoryMQ site connector installer

    .DESCRIPTION
    Downloads the MemoryMQ site connector service installer, configured for the given site connector, as a zip file into a folder.
    Works only for MemoryMQ site connectors; the server rejects RabbitMQ and Azure Service Bus connectors.
    Returns the downloaded file.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Site connector ID

    .PARAMETER Output
    Folder to save the zip file in; the file is named Thycotic.MemoryMq.SiteConnector.Service.x64.<Id>.zip and an existing file is overwritten

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineSiteConnectorDownload -TssSession $session -Id 1 -Output C:\installers

    Downloads the installer for site connector 1 into C:\installers

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineSiteConnectorDownload

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineSiteConnectorDownload.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.IO.FileInfo')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SiteConnectorId')]
        [int[]]
        $Id,

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
            foreach ($currentId in $Id) {
                $filePath = [IO.Path]::Combine((Resolve-Path -LiteralPath $Output).ProviderPath, "Thycotic.MemoryMq.SiteConnector.Service.x64.$currentId.zip")
                $uri = $TssSession.ApiUrl, 'distributed-engine', 'site-connector', $currentId, 'download-memorymq' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri [OutFile: $filePath]"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    if ($apiResponse.IsSuccessful) {
                        [IO.File]::WriteAllBytes($filePath, $apiResponse.RawBytes)
                        Get-Item -LiteralPath $filePath
                    } else {
                        . $ProcessResponse $apiResponse
                    }
                } catch {
                    Write-Warning 'Issue with Get-TssDistributedEngineSiteConnectorDownload request'
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
