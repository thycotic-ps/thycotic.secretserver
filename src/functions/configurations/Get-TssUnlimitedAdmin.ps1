function Get-TssUnlimitedAdmin {
    <#
    .SYNOPSIS
    Get the Unlimited Admin Mode state

    .DESCRIPTION
    Returns whether Unlimited Admin Mode is currently enabled.
    Use Enable-TssUnlimitedAdmin and Disable-TssUnlimitedAdmin to change it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUnlimitedAdmin -TssSession $session

    Returns the current Unlimited Admin Mode state, Enabled is True or False

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    if ((Get-TssUnlimitedAdmin -TssSession $session).Enabled) { Disable-TssUnlimitedAdmin -TssSession $session -Note 'Troubleshooting complete' }

    Turns Unlimited Admin Mode off only when it is on

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssUnlimitedAdmin

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssUnlimitedAdmin.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.UnlimitedAdmin')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'unlimited-admin' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssUnlimitedAdmin request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.UnlimitedAdmin](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.UnlimitedAdmin]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
