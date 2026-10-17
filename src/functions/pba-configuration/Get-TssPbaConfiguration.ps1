function Get-TssPbaConfiguration {
    <#
    .SYNOPSIS
    Get the Privilege Behavior Analytics (PBA) configuration

    .DESCRIPTION
    Returns the PBA integration settings: enabled state, PBA URL, upload and metadata intervals, retention, challenge options and key pair status.
    PbaKey and SecretServerKey are key pair ids, not key material.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPbaConfiguration -TssSession $session

    Returns the PBA configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Get-TssPbaConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Get-TssPbaConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the View or Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.PbaConfiguration.Configuration')]
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
            $uri = $TssSession.ApiUrl, 'pba-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPbaConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.PbaConfiguration.Configuration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PbaConfiguration.Configuration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
