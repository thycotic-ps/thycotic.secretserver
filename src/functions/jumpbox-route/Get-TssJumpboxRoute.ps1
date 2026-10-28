function Get-TssJumpboxRoute {
    <#
    .SYNOPSIS
    Get a jumpbox route

    .DESCRIPTION
    Returns the jumpbox route with the given ID, including its levels.
    A jumpbox route sends a proxied SSH session through one or more intermediate hosts (levels) before it reaches the target.
    Requires the View Jumpbox Route or Administer Jumpbox Route role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Jumpbox route ID (a GUID)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssJumpboxRoute -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Returns the jumpbox route with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssJumpboxRoute -TssSession $session -SearchTerm 'DMZ' | Get-TssJumpboxRoute -TssSession $session

    Returns the full details of every active jumpbox route with "DMZ" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/jumpbox-route/Get-TssJumpboxRoute

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/jumpbox-route/Get-TssJumpboxRoute.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.JumpboxRoute.JumpboxRoute')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('JumpboxRouteId')]
        [string[]]
        $Id
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
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'jumpbox-route', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssJumpboxRoute request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.JumpboxRoute.JumpboxRoute](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.JumpboxRoute.JumpboxRoute]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
