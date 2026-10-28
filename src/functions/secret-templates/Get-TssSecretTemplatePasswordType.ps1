function Get-TssSecretTemplatePasswordType {
    <#
    .SYNOPSIS
    Get the password changing settings of a secret template

    .DESCRIPTION
    Returns the password type (password changer) of a secret template, its remote password changing and heartbeat settings, and the mapping of template fields to password type fields.
    PasswordTypeId is empty when no password type is assigned.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplatePasswordType -TssSession $session -Id 6007

    Get the password changing settings of template 6007

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplatePasswordType

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplatePasswordType.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.PasswordType')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateId')]
        [int[]]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-templates', $currentId, 'password-type' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretTemplatePasswordType request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.PasswordType](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.PasswordType]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
