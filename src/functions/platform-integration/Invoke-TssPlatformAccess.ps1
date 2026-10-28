function Invoke-TssPlatformAccess {
    <#
    .SYNOPSIS
    Start the secure Platform access step of Delinea Platform data integration

    .DESCRIPTION
    Starts the secure access step of Delinea Platform data integration, in which Secret Server configures the Platform identity policies and policy group it needs.
    The call only starts the step. Use Get-TssPlatformAccessProgress to follow it.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssPlatformAccess -TssSession $session -Confirm:$false

    Starts the secure Platform access step without prompting and returns True when the server accepted the request

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssPlatformAccess -TssSession $session -WhatIf

    Shows the request that would be sent without starting the step

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Invoke-TssPlatformAccess

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Invoke-TssPlatformAccess.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Returns True or False (the success flag of the response).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'platform-integration', 'platform-access' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Platform access", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Invoke-TssPlatformAccess request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse.success)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
