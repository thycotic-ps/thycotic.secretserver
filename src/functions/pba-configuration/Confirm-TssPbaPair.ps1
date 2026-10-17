function Confirm-TssPbaPair {
    <#
    .SYNOPSIS
    Confirm the Secret Server key pair with Privilege Behavior Analytics (PBA)

    .DESCRIPTION
    Queues confirmation of the Secret Server application key with the configured PBA instance.
    AlreadyApproved is true when the current key is already approved, in which case nothing is queued.
    Fails when PBA is not configured.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Confirm-TssPbaPair -TssSession $session

    Confirms the key pair with PBA

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Confirm-TssPbaPair

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Confirm-TssPbaPair.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PbaConfiguration.PairResult')]
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
            $uri = $TssSession.ApiUrl, 'pba-confirm-pair' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Pba pair", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Confirm-TssPbaPair request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PbaConfiguration.PairResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PbaConfiguration.PairResult]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
