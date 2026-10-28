function Get-TssDualControlStub {
    <#
    .SYNOPSIS
    Get a dual control stub

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    Returns a dual control with the default values Secret Server uses for a new one.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDualControlStub -TssSession $session

    Get the default values for a new dual control

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Get-TssDualControlStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Get-TssDualControlStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DualControls.DualControl')]
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
            $uri = $TssSession.ApiUrl, 'dual-controls', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssDualControlStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.DualControls.DualControl](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.DualControls.DualControl]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
