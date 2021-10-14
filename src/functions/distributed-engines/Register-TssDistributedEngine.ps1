function Register-TssDistributedEngine {
    <#
    .SYNOPSIS
    Activate a Distributed Engine for a Site

    .DESCRIPTION
    Activate a Distributed Engine for a Site

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Register-TssDistributedEngine -TssSession $session -EngineId 6 -SiteId 5

    Activate Engine ID 6 on Site ID 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Register-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Register-TssDistributedEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineActivation')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Engine ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EngineId')]
        [int[]]
        $Id,

        # Site ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SiteId
    )
    begin {
        $tssParams = $PSBoundParameters
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        $tssParams.Add('Status','Activate')
        Update-TssDistributedEngine @tssParams
    }
}