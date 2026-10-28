function Get-TssIcon {
    <#
    .SYNOPSIS
    Save an icon to a file

    .DESCRIPTION
    Download an icon by Id and save it as icon-<Id>.ico in the Output folder. Returns the saved file. An Id without an icon saves nothing and writes a warning.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Icon Id

    .PARAMETER Output
    Folder the icon files are saved to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssIcon -TssSession $session -Id 1 -Output $env:TEMP

    Save icon 1 as icon-1.ico in the temp folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/icon/Get-TssIcon

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/icon/Get-TssIcon.ps1

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
            $outputPath = $PSCmdlet.GetUnresolvedProviderPathFromPSPath($Output)
            foreach ($currentId in $Id) {
                $apiResponse = $null
                $uri = $TssSession.ApiUrl, 'icon', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                } catch {
                    Write-Warning 'Issue with Get-TssIcon request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -eq $apiResponse) {
                    continue
                }
                if ([int]$apiResponse.StatusCode -eq 204) {
                    Write-Warning "No icon found for Id $currentId"
                } elseif ([int]$apiResponse.StatusCode -eq 200) {
                    $outFile = [System.IO.Path]::Combine($outputPath, "icon-$currentId.ico")
                    [System.IO.File]::WriteAllBytes($outFile, $apiResponse.RawBytes)
                    Get-Item -LiteralPath $outFile
                } else {
                    . $ProcessResponse $apiResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
