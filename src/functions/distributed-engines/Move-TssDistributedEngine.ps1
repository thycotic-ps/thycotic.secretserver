function Move-TssDistributedEngine {
    <#
    .SYNOPSIS
    Migrate a Distributed Engine to the Delinea Platform engine pool

    .DESCRIPTION
    Starts the migration of a Distributed Engine to the Delinea Platform engine pool.
    Works only on a Secret Server connected to the Delinea Platform with an engine that is eligible for migration; otherwise the server rejects the request.
    Returns Success and, when the migration did not start, ErrorMessage.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Distributed Engine ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssDistributedEngine -TssSession $session -Id 7

    Migrates Distributed Engine 7 to the Platform engine pool after confirmation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDistributedEngine -TssSession $session -SiteId 3 | Move-TssDistributedEngine -TssSession $session -Confirm:$false

    Migrates every engine on site 3 without prompting

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/distributed-engines/Move-TssDistributedEngine

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/distributed-engines/Move-TssDistributedEngine.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Moves the engine to the Platform engine pool. This cmdlet has no reverse operation, so it asks for confirmation by default.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.DistributedEngines.EngineMigration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EngineId')]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '12.1.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'distributed-engine', 'engine', $Id, 'migrate' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Distributed engine: $Id", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Move-TssDistributedEngine request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DistributedEngines.EngineMigration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DistributedEngines.EngineMigration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
