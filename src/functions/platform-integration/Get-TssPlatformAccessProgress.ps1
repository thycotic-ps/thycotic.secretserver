function Get-TssPlatformAccessProgress {
    <#
    .SYNOPSIS
    Get the progress of the secure Platform access step of Delinea Platform data integration

    .DESCRIPTION
    Returns the state of each check in the secure Platform access step: identity policy, deny policy, policy order and policy group membership.
    Each property is one of NotStarted, Started, CompletedSuccessfully, CompletedInvalid or Skipped.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformAccessProgress -TssSession $session

    Returns the state of each secure Platform access check

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $progress = Get-TssPlatformAccessProgress -TssSession $session
    $progress.PSObject.Properties | Where-Object Value -eq 'CompletedInvalid'

    Lists the checks that completed but are not valid

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformAccessProgress

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformAccessProgress.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PlatformIntegration.PlatformAccessProgress')]
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
            $uri = $TssSession.ApiUrl, 'platform-integration', 'platform-access-progress' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformAccessProgress request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PlatformIntegration.PlatformAccessProgress](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PlatformIntegration.PlatformAccessProgress]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
