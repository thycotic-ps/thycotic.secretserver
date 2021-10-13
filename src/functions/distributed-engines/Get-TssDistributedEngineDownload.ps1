function Get-TssDistributedEngineDownload {
    <#
    .SYNOPSIS
    Download the Distributed Engine installer for a Site

    .DESCRIPTION
    Download the Distributed Engine installer for a Site

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDistributedEngineDownload -TssSession $session -SiteId 4

    Download the installer for Distributed Engine to add to Site ID 4

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Get-TssDistributedEngineDownload

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Get-TssDistributedEngineDownload.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Site ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [int]
        $SiteId,

        # Output folder
        [Parameter(Mandatory)]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Output
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $downloadPrefix = 'Thycotic.DistributedEngine.Service'
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation

            $site = Get-TssSite -TssSession $TssSession | Where-Object SiteId -EQ $SiteId
            if ($site) {
                $downloadFileName = $downloadPrefix, $site.SiteName, 'zip' -join '.'
                $finalFullPath = [IO.Path]::Combine($Output, $downloadFileName)
                $invokeParams.OutFile = $finalFullPath

                $uri = $TssSession.ApiUrl, 'distributed-engine', 'download-distributed-engine' -join '/'
                $uri = $uri + "?siteId=$SiteId&is64Bit=true"
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) [OutFile: $finalFullPath]"
                try {
                    Invoke-TssApi @invokeParams
                } catch {
                    Write-Warning "Issue getting reference name on [$site]"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}