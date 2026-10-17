function Get-TssSecretTemplate {
    <#
    .SYNOPSIS
    Get a secret template from Secret Server

    .DESCRIPTION
    Get a secret template(s) from Secret Server

    .PARAMETER Detail
    Return the template settings (name pattern, expiration, one-time password, SSH key and other settings) from the version 2 endpoint instead of the template and its fields

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplate -Id 93

    Returns secret associated with the Secret ID, 93

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplate -TssSession $session -Id 6007 -Detail

    Returns the settings of secret template 6007, such as name pattern, expiration, one-time password and SSH key settings

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplate

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplate.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Template')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Detail')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret template ID to retrieve
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretTemplateId')]
        [Alias('TemplateId')]
        [int[]]
        $Id,

        [switch]
        $Detail
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($template in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-templates', $template -join '/'
                if ($Detail) {
                    $uri = ($TssSession.ApiUrl -replace 'v1$','v2'), 'secret-templates', $template -join '/'
                }
                $invokeParams.Uri = $Uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParas.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting template [$template]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse -and $Detail) {
                    [Thycotic.PowerShell.SecretTemplates.Detail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Detail]))
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Template](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Template]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
