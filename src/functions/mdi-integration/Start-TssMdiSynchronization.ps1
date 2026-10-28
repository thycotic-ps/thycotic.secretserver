function Start-TssMdiSynchronization {
    <#
    .SYNOPSIS
    Start an MDI synchronization

    .DESCRIPTION
    Start a Microsoft Defender for Identity (MDI) synchronization now. Returns True when the synchronization was queued. The integration must be configured and consented first.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssMdiSynchronization -TssSession $session
    Get-TssMdiSynchronization -TssSession $session

    Start an MDI synchronization, then check its progress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/mdi-integration/Start-TssMdiSynchronization

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mdi-integration/Start-TssMdiSynchronization.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
            $uri = $TssSession.ApiUrl, 'mdi-integration', 'synchronize-now' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("MDI synchronization", "$($invokeParams.Method) $uri")) {
                $restResponse = $null
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssMdiSynchronization request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
