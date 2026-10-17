function Get-TssReadOnlyMode {
    <#
    .SYNOPSIS
    Get the Read-Only Mode setting

    .DESCRIPTION
    Returns whether Secret Server is in Read-Only Mode.
    In Read-Only Mode users can view secrets but Secret Server rejects some changes, such as creating a secret or saving a whole secret (Update-TssSecret). Not every change is blocked: creating a folder still works, and a single field update (Set-TssSecretField) can still save its value, even when it returns a read-only error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReadOnlyMode -TssSession $session

    Returns whether Read-Only Mode is enabled

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssReadOnlyMode

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssReadOnlyMode.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.ReadOnlyMode')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'read-only-mode' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssReadOnlyMode request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.ReadOnlyMode](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ReadOnlyMode]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
