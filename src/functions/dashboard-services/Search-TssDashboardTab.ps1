function Search-TssDashboardTab {
    <#
    .SYNOPSIS
    List the dashboard tabs of the current user

    .DESCRIPTION
    Returns every dashboard tab of the current user with its id, name, type and hash parameters. The list is not paged.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDashboardTab -TssSession $session

    List the dashboard tabs of the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dashboard-services/Search-TssDashboardTab

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dashboard-services/Search-TssDashboardTab.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DashboardServices.DashboardTab[]')]
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
            $uri = $TssSession.ApiUrl, 'dashboard-services', 'tabs', 'pinned' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDashboardTab request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DashboardServices.DashboardTab[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DashboardServices.DashboardTab]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
