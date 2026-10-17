function New-TssGeneratedPassword {
    <#
    .SYNOPSIS
    Generate a password for a secret template field

    .DESCRIPTION
    Returns a new password that meets the password requirements of a password field on a secret template.
    Nothing is saved on the server.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template field ID of a password field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssGeneratedPassword -TssSession $session -Id 108

    Returns a new password for secret template field 108

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    (Get-TssSecretTemplate -TssSession $session -Id 6).Fields | Where-Object IsPassword | New-TssGeneratedPassword -TssSession $session

    Returns a new password for each password field of secret template 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssGeneratedPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssGeneratedPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.String')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateFieldId', 'SecretFieldId')]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', 'generate-password', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Generated password: $Id", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                $restResponse = $null
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssGeneratedPassword request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    $restResponse | ConvertFrom-Json
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
