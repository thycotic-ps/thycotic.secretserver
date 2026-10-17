function Get-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Get secret template fields

    .DESCRIPTION
    Get a secret template field by its field ID, with its data type, dropdown options and permission settings.
    With -SecretTemplateId, get the field labels of a secret template instead. Basic users can read the labels.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret template field ID

    .PARAMETER SecretTemplateId
    Secret template ID whose field labels to get

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplateField -TssSession $session -Id 108

    Get secret template field 108

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretTemplateField -TssSession $session -SecretTemplateId 6007

    Get the field labels of template 6007

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Get-TssSecretTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Get-TssSecretTemplateField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.FieldDetail', ParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.SecretTemplates.FieldLabel', ParameterSetName = 'Template')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'Default')]
        [Alias('SecretFieldId', 'FieldId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'Template')]
        [Alias('TemplateId')]
        [int[]]
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
            $targetIds = if ($PSCmdlet.ParameterSetName -eq 'Template') { $SecretTemplateId } else { $Id }
            foreach ($currentId in $targetIds) {
                $restResponse = $null
                switch ($PSCmdlet.ParameterSetName) {
                    'Template' {
                        $uri = $TssSession.ApiUrl, 'secret-templates', 'fields', 'basic', $currentId -join '/'
                    }
                    default {
                        $uri = $TssSession.ApiUrl, 'secret-templates', 'fields', $currentId -join '/'
                    }
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssSecretTemplateField request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($PSCmdlet.ParameterSetName -eq 'Template') {
                    if ($restResponse.fields) {
                        [Thycotic.PowerShell.SecretTemplates.FieldLabel[]](. $FilterTssResponse $restResponse.fields ([Thycotic.PowerShell.SecretTemplates.FieldLabel]))
                    }
                } elseif ($restResponse) {
                    [Thycotic.PowerShell.SecretTemplates.FieldDetail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.FieldDetail]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
