function Search-TssDependencyChangerSetting {
    <#
    .SYNOPSIS
    List dependency changer settings

    .DESCRIPTION
    Returns the catalog of dependency changer settings (for example Port, WaitBeforeSeconds) with their default values. Use the setting names with -Setting on New-TssDependencyChanger and Set-TssDependencyChanger.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDependencyChangerSetting -TssSession $session

    List the dependency changer settings and their defaults

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dependency-changers/Search-TssDependencyChangerSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dependency-changers/Search-TssDependencyChangerSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DependencyChangers.Setting[]')]
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
            $uri = $TssSession.ApiUrl, 'dependency-changers', 'dependency-changer-settings' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDependencyChangerSetting request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DependencyChangers.Setting[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DependencyChangers.Setting]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
