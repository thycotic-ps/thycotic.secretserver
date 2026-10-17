function Set-TssSecretTemplateLauncher {
    <#
    .SYNOPSIS
    Set the launcher settings of a secret template

    .DESCRIPTION
    Changes the settings of a launcher on a secret template: field mappings, input restrictions and connect-as settings. Only the parameters you pass are changed.
    Returns the updated launcher.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER LauncherTypeId
    Launcher type ID of the launcher to change

    .PARAMETER SecretTemplateId
    Secret template ID

    .PARAMETER AllowList
    Secret template field ID that holds the allow list of hosts

    .PARAMETER ConnectAsCommand
    Command the SSH proxy runs to switch user, such as 'su - $USERNAME'

    .PARAMETER ConnectAsCommandResponse
    Prompt the connect-as command expects and the field token to answer it with

    .PARAMETER ConnectAsTimeoutInSeconds
    Timeout of the connect-as command, in seconds

    .PARAMETER DenyList
    Secret template field ID that holds the deny list of hosts

    .PARAMETER ExpectedPromptEnding
    Character that ends the server prompt, such as $ or #

    .PARAMETER Field
    Launcher field mappings that replace the current ones: objects with LauncherTypeFieldId, SecretFieldId and optional DefaultValue properties, such as the Fields of Get-TssSecretTemplateLauncher output. SecretFieldId is a secret template field ID, or -1 (blank), -2 (user input) or -3 (use DefaultValue)

    .PARAMETER IncludeMachinesFromDependencies
    Add the machines of secret dependencies to the allowed hosts, or not with -IncludeMachinesFromDependencies:$false

    .PARAMETER LineEnding
    Line ending sent after the connect-as command

    .PARAMETER RestrictAs
    How user input is restricted, as in the RestrictAs value of Get-TssSecretTemplateLauncher

    .PARAMETER RestrictBySecretField
    Secret template field ID whose value restricts the hosts a user can connect to

    .PARAMETER RestrictUserInput
    Restrict the hosts a user can enter, or allow any host with -RestrictUserInput:$false. Enabling it requires a launcher field mapped to user input (-2) and one of -AllowList, -DenyList, -RestrictAs or -RestrictBySecretField, because Secret Server derives the restriction from those settings

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2 -RestrictUserInput:$false

    Let users of launcher type 2 on template 6007 connect to any host

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $launcher = Get-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2
    ($launcher.Fields | Where-Object launcherTypeFieldName -EQ 'Port').defaultValue = '2222'
    Set-TssSecretTemplateLauncher -TssSession $session -SecretTemplateId 6007 -LauncherTypeId 2 -Field $launcher.Fields

    Change the default port of launcher type 2 on template 6007 to 2222, keeping the other field mappings
    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Set-TssSecretTemplateLauncher

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Set-TssSecretTemplateLauncher.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
        $SecretTemplateId,

        [int]
        $AllowList,

        [string]
        $ConnectAsCommand,

        [string]
        $ConnectAsCommandResponse,

        [int]
        $ConnectAsTimeoutInSeconds,

        [int]
        $DenyList,

        [string]
        $ExpectedPromptEnding,

        [Alias('Fields')]
        [object[]]
        $Field,

        [switch]
        $IncludeMachinesFromDependencies,

        [string]
        $LineEnding,

        [int]
        $RestrictAs,

        [int]
        $RestrictBySecretField,

        [switch]
        $RestrictUserInput
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
            if ($RestrictUserInput -and -not ($tssParams.Keys | Where-Object { $_ -in 'AllowList', 'DenyList', 'RestrictAs', 'RestrictBySecretField' })) {
                Write-Error '-RestrictUserInput requires -AllowList, -DenyList, -RestrictAs or -RestrictBySecretField'
                return
            }
            $uri = $TssSession.ApiUrl, 'secret-templates', $SecretTemplateId, 'launchers', $LauncherTypeId -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AllowList' {
                    $body.data.Add('allowList', @{ dirty = $true; value = $AllowList })
                }
                'ConnectAsCommand' {
                    $body.data.Add('connectAsCommand', @{ dirty = $true; value = $ConnectAsCommand })
                }
                'ConnectAsCommandResponse' {
                    $body.data.Add('connectAsCommandResponse', @{ dirty = $true; value = $ConnectAsCommandResponse })
                }
                'ConnectAsTimeoutInSeconds' {
                    $body.data.Add('connectAsTimeoutInSeconds', @{ dirty = $true; value = $ConnectAsTimeoutInSeconds })
                }
                'DenyList' {
                    $body.data.Add('denyList', @{ dirty = $true; value = $DenyList })
                }
                'ExpectedPromptEnding' {
                    $body.data.Add('expectedPromptEnding', @{ dirty = $true; value = $ExpectedPromptEnding })
                }
                'Field' {
                    $fieldMappings = @(foreach ($mapping in $Field) {
                            @{
                                secretFieldId       = $mapping.SecretFieldId
                                launcherTypeFieldId = [int]$mapping.LauncherTypeFieldId
                                defaultValue        = $mapping.DefaultValue
                                promptableField     = [boolean]$mapping.PromptableField
                            }
                        })
                    $body.data.Add('fields', @{ dirty = $true; value = $fieldMappings })
                }
                'IncludeMachinesFromDependencies' {
                    $body.data.Add('includeMachinesFromDependencies', @{ dirty = $true; value = [boolean]$IncludeMachinesFromDependencies })
                }
                'LineEnding' {
                    $body.data.Add('lineEnding', @{ dirty = $true; value = $LineEnding })
                }
                'RestrictAs' {
                    $body.data.Add('restrictAs', @{ dirty = $true; value = $RestrictAs })
                }
                'RestrictBySecretField' {
                    $body.data.Add('restrictBySecretField', @{ dirty = $true; value = $RestrictBySecretField })
                }
                'RestrictUserInput' {
                    $body.data.Add('restrictUserInput', @{ dirty = $true; value = [boolean]$RestrictUserInput })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret template: $SecretTemplateId, launcher type: $LauncherTypeId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssSecretTemplateLauncher request'
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
