function Get-TssSecretTemplateLauncher {
    <#
    .SYNOPSIS
    Get a launcher configured on a secret template

    .DESCRIPTION
    Returns the settings of one launcher type on a secret template: field mappings, input restrictions and connect-as settings.
    Search-TssSecretTemplateLauncher lists the launchers of a template and the available launcher types.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER LauncherTypeId
    Launcher type ID, as returned by Search-TssSecretTemplateLauncher -LauncherType

    .PARAMETER SecretTemplateId
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2

    Get the settings of launcher type 2 on template 6007

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Launcher')]
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
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretTemplateLauncher request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.SecretTemplates.Launcher](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Launcher]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
