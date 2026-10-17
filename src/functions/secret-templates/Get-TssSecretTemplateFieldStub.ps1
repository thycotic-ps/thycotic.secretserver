function Get-TssSecretTemplateFieldStub {
    <#
    .SYNOPSIS
    Get a new secret template field with default values

    .DESCRIPTION
    Returns an unsaved secret template field filled with the Secret Server defaults. Nothing is created.
    Use it to see the default field settings before adding a field with Add-TssSecretTemplateField.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplateFieldStub -TssSession $session

    Get the default settings of a new secret template field

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateFieldStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateFieldStub.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.FieldDetail')]
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
            $uri = $TssSession.ApiUrl, 'secret-templates', 'fields', 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretTemplateFieldStub request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretTemplates.FieldDetail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.FieldDetail]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
