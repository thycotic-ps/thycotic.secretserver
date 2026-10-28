function Get-TssDiscoveryCommandSet {
    <#
    .SYNOPSIS
    Get a Discovery command set

    .DESCRIPTION
    Returns one or more Discovery command sets by id, including the commands they run.
    An id with no matching command set writes an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Discovery command set id

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDiscoveryCommandSet -TssSession $session -Id 5

    Get Discovery command set 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Get-TssDiscoveryCommandSet

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Get-TssDiscoveryCommandSet.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Discovery.CommandSet')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CommandSetId', 'DiscoveryCommandSetId')]
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
                $uri = $TssSession.ApiUrl, 'discovery', 'command-sets', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDiscoveryCommandSet request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse -eq 'null') {
                    $PSCmdlet.WriteError([Management.Automation.ErrorRecord]::new([Exception]::new("Discovery command set $currentId not found"), 'CommandSetNotFound', 'ObjectNotFound', $currentId))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.Discovery.CommandSet](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Discovery.CommandSet]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
