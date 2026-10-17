function New-TssSecretTemplateLauncher {
    <#
    .SYNOPSIS
    Add a launcher to a secret template

    .DESCRIPTION
    Adds a launcher type to a secret template and maps each launcher field to a secret template field, so secrets based on the template offer that launcher.
    Get-TssSecretTemplateLauncherStub lists the launcher fields to map. Its result can be piped to this command once every field has a SecretFieldId the launcher accepts.
    Use Set-TssSecretTemplateLauncher to change an existing launcher and Remove-TssSecretTemplateLauncher to remove it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER SecretTemplateId
    Secret template ID

    .PARAMETER LauncherTypeId
    Launcher type ID to add, as returned by Search-TssSecretTemplateLauncher -LauncherType

    .PARAMETER Field
    One mapping per launcher field: objects with LauncherTypeFieldId, SecretFieldId and optional DefaultValue properties, such as the Fields of Get-TssSecretTemplateLauncherStub output. SecretFieldId is a secret template field ID, or -1 (blank), -2 (user input) or -3 (use DefaultValue). Each secret template field can be used once. Review every SecretFieldId of a stub before creating: Secret Server rejects its 0 placeholders and some of its suggested special values

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $fields = @(
        [pscustomobject]@{ LauncherTypeFieldId = 5; SecretFieldId = 108 },
        [pscustomobject]@{ LauncherTypeFieldId = 6; SecretFieldId = 110 },
        [pscustomobject]@{ LauncherTypeFieldId = 7; SecretFieldId = 111 },
        [pscustomobject]@{ LauncherTypeFieldId = 22; SecretFieldId = -3; DefaultValue = '22' }
    )
    New-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2 -Field $fields

    Add the PuTTY launcher (type 2) to template 6007: host, password and username from template fields 108, 110 and 111, port 22 as a default value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $stub = Get-TssSecretTemplateLauncherStub -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
    $secretFieldIds = @{ Host = 108; Password = 110; Username = 111; Port = -3 }
    foreach ($field in $stub.Fields) { $field.secretFieldId = $secretFieldIds[$field.launcherTypeFieldName] }
    ($stub.Fields | Where-Object launcherTypeFieldName -EQ 'Port').defaultValue = '22'
    $stub | New-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007

    Start from the stub, map every launcher field by name, and add the launcher to template 6007
    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Launcher')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('TemplateId')]
        [int]
        $SecretTemplateId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $LauncherTypeId,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Fields')]
        [object[]]
        $Field
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'secret-templates', $SecretTemplateId, 'launchers', $LauncherTypeId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $fieldMappings = @(foreach ($mapping in $Field) {
                    @{
                        launcherTypeFieldId = [int]$mapping.LauncherTypeFieldId
                        secretFieldId       = [int]$mapping.SecretFieldId
                        defaultValue        = $mapping.DefaultValue
                    }
                })
            $body = @{ data = @{ fields = $fieldMappings } }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template: $SecretTemplateId, launcher type: $LauncherTypeId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssSecretTemplateLauncher request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.Launcher](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.Launcher]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
