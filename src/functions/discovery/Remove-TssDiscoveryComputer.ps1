function Remove-TssDiscoveryComputer {
    <#
    .SYNOPSIS
    Remove discovered computers

    .DESCRIPTION
    Deletes one or more discovered computers and their discovered accounts and dependencies in one request. Returns one result per computer.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovered computer id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDiscoveryComputer -TssSession $session -Id 42, 43

    Delete discovered computers 42 and 43

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Remove-TssDiscoveryComputer

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Remove-TssDiscoveryComputer.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Discovery.ComputerDeleteResult[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ComputerId', 'NetworkItemId')]
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
            $uri = $TssSession.ApiUrl, 'discovery', 'network', 'item', 'computer', 'delete' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @($Id) }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Discovery computer: $($Id -join ', ')", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssDiscoveryComputer request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.results) {
                    [Thycotic.PowerShell.Discovery.ComputerDeleteResult[]](. $FilterTssResponse $restResponse.results ([Thycotic.PowerShell.Discovery.ComputerDeleteResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
