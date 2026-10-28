function Get-TssSecretImportConfiguration {
    <#
    .SYNOPSIS
    Get the secret import settings

    .DESCRIPTION
    Returns whether imported secrets need a folder and whether duplicate secret names are allowed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretImportConfiguration -TssSession $session

    Returns the secret import settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretImportConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretImportConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.ImportConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'secrets', 'import-configuration' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretImportConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Secrets.ImportConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ImportConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
