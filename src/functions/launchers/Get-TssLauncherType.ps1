function Get-TssLauncherType {
    <#
    .SYNOPSIS
    Get a launcher type

    .DESCRIPTION
    Get every detail of a launcher type, built-in or custom.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher type Id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherType -TssSession $session -Id 2

    Get the details of launcher type 2

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launchers/Get-TssLauncherType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launchers/Get-TssLauncherType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Launchers.LauncherType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('LauncherTypeId')]
        [int[]]
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
                $uri = $TssSession.ApiUrl, 'launchers', 'types', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssLauncherType request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Launchers.LauncherType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Launchers.LauncherType]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
