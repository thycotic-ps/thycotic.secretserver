function Get-TssSecretTemplateLauncherStub {
    <#
    .SYNOPSIS
    Get the default launcher settings for a launcher type on a secret template

    .DESCRIPTION
    Returns unsaved launcher settings that map a launcher type onto a secret template, with the field mappings Secret Server suggests. Nothing is created.
    Launcher fields the stub cannot map have SecretFieldId 0; set them to a secret template field ID, or -1 (blank), -2 (user input) or -3 (use DefaultValue), then pass the result to New-TssSecretTemplateLauncher.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER LauncherTypeId
    Launcher type ID, as returned by Search-TssSecretTemplateLauncher -LauncherType

    .PARAMETER SecretTemplateId
    Secret template ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $stub = Get-TssSecretTemplateLauncherStub -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
    $stub.Fields

    Show the field mappings Secret Server suggests for launcher type 2 on template 6007

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateLauncherStub

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateLauncherStub.ps1

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
            $uri = $TssSession.ApiUrl, 'secret-templates', $SecretTemplateId, 'launchers', $LauncherTypeId, 'stub' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSecretTemplateLauncherStub request'
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
