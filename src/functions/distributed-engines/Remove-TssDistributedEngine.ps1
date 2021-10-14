function Remove-TssDistributedEngine {
    <#
    .SYNOPSIS
    Remove an Distributed Engine from a Site

    .DESCRIPTION
    Remove an Distributed Engine from a Site

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDistributedEngine -TssSession $session -EngineId 4 -SiteId 3

    Add minimum example for each parameter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Remove-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Remove-TssDistributedEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Distributed Engine ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $EngineId,

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
        $tssParams.Add('Status','Delete')
        Update-TssDistributedEngine @tssParams
    }
}