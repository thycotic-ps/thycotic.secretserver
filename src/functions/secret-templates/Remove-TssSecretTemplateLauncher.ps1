function Remove-TssSecretTemplateLauncher {
    <#
    .SYNOPSIS
    Remove a launcher from a secret template

    .DESCRIPTION
    Removes a launcher type from a secret template, so secrets based on the template no longer offer that launcher. The launcher type itself is not changed.
    Returns Success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER LauncherTypeId
    Launcher type ID to remove from the template

    .PARAMETER SecretTemplateId
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2

    Remove launcher type 2 from template 6007

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Remove-TssSecretTemplateLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Remove-TssSecretTemplateLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Result')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $LauncherTypeId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $SecretTemplateId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'secret-templates', $SecretTemplateId, 'launchers', $LauncherTypeId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'DELETE'
            if ($PSCmdlet.ShouldProcess("Secret template: $SecretTemplateId, launcher type: $LauncherTypeId", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Remove-TssSecretTemplateLauncher request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Result](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Result]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
