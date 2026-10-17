function Get-TssMdiSynchronization {
    <#
    .SYNOPSIS
    Get the MDI synchronization status

    .DESCRIPTION
    Get the status of the current or last Microsoft Defender for Identity (MDI) synchronization: start and end time, estimated progress, error count and the next scheduled run. Returns nothing when no synchronization has run.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMdiSynchronization -TssSession $session

    Show the MDI synchronization status

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/mdi-integration/Get-TssMdiSynchronization

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/mdi-integration/Get-TssMdiSynchronization.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.MdiIntegration.Synchronization')]
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
            $uri = $TssSession.ApiUrl, 'mdi-integration', 'synchronization' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssMdiSynchronization request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse -and $restResponse -ne 'null') {
                [Thycotic.PowerShell.MdiIntegration.Synchronization](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.MdiIntegration.Synchronization]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
