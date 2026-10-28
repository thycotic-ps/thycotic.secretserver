function Get-TssDualControl {
    <#
    .SYNOPSIS
    Get a dual control by ID

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    Returns the dual control with its type, item and approval groups.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dual control ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDualControl -TssSession $session -Id 3

    Get dual control 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControl

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControl.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DualControls.DualControl')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
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
                $uri = $TssSession.ApiUrl, 'dual-controls', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssDualControl request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.DualControls.DualControl](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DualControls.DualControl]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
