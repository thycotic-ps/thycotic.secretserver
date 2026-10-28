function Get-TssPublicSshKeyConfiguration {
    <#
    .SYNOPSIS
    Get the public SSH key configuration

    .DESCRIPTION
    Returns the public SSH key settings: whether users can manage public SSH keys, whether a passphrase is required and when keys expire.
    No key material is returned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPublicSshKeyConfiguration -TssSession $session

    Returns the public SSH key configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssPublicSshKeyConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssPublicSshKeyConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.PublicSshKeyConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'public-ssh-key' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPublicSshKeyConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.PublicSshKeyConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.PublicSshKeyConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
