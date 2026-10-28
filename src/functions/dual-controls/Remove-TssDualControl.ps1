function Remove-TssDualControl {
    <#
    .SYNOPSIS
    Remove a dual control

    .DESCRIPTION
    A dual control requires a member of an approval group to authorize an action (running a report, viewing a secret session recording, viewing all secret sessions) before it can proceed.
    Removes the dual control: the action it protected no longer needs an approval. Secret Server keeps the record and marks it inactive, so Get-TssDualControl still returns it and Search-TssDualControl -IncludeInactive lists it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Dual control ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssDualControl -TssSession $session -Id 3

    Remove dual control 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDualControl -TssSession $session | Where-Object DualControlTypeName -eq 'Access Report' | Remove-TssDualControl -TssSession $session

    Remove every active Access Report dual control

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/dual-controls/Remove-TssDualControl

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/dual-controls/Remove-TssDualControl.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
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
                $invokeParams.Method = 'DELETE'
                if ($PSCmdlet.ShouldProcess("Dual control: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Remove-TssDualControl request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Common.Delete]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
