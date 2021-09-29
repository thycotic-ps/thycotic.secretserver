function Test-TssVersion {
    <#
    .SYNOPSIS
    Test Secret Server version

    .DESCRIPTION
    Tests whether Secret Server version returned by Get-TssVersion is the latest

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssVersion -TssSession $session

    Pulls version of Secret Server and queries for latest version, returning object with details

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/version/Test-TssVersion

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/version/Test-TssVersion.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Common.TestVersion')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            $getVersion = Get-TssVersion -TssSession $TssSession

            if ($getVersion.Version) {
                $uri = "https://updates.thycotic.net/secretserver/LatestVersion.aspx?v=$($getVersion.Version)"
                try {
                    $apiResponse = Invoke-TssApi -Uri $uri -Method GET
                    $latestResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting latest version information from [$uri]"
                    $err = $_
                    . $ErrorHandling $err
                }
            }

            if ($latestResponse) {
                $isLatest = if ($getVersion.Version -ge $latestResponse) { $true }
                [Thycotic.PowerShell.Common.TestVersion]@{
                    Version       = $getVersion.Version
                    Major         = $getVersion.Major
                    Minor         = $getVersion.Minor
                    Build         = $getVersion.Build
                    LatestVersion = $latestResponse
                    IsLatest      = $isLatest
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}