function Add-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Add a new field to a Secret Template

    .DESCRIPTION
    Add a new field to a Secret Template
    With -Name and -FieldSlugName, the field is created from those values instead of a New-TssSecretTemplateField object, and the new field is returned

    .PARAMETER Name
    Display name of the new field

    .PARAMETER FieldSlugName
    Slug name of the new field, unique on the template; scripts and the API use it to reference the field

    .PARAMETER Description
    Description of the new field

    .PARAMETER DataType
    Data type of the new field. Secret Server uses Text when omitted

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    (Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
    $newField = New-TssSecretTemplateField -FieldName 'Additional Field' -Searchable
    Add-TssSecretTemplateField -TssSession $session -Id 6042 -Field $newField
    (Get-TssSecretTemplate -TssSession $session -Id 6042).Fields

    Output the current fields for Secret Template 6042, create a new field named "Additional Field" that is searchable and add to the Secret Template 6042

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Add-TssSecretTemplateField -TssSession $session -Id 6007 -Name 'Owner' -FieldSlugName 'owner' -Description 'Team that owns the account'

    Add a text field named Owner to Secret Template 6007 and return the new field

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/Add-TssSecretTemplateField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/Add-TssSecretTemplateField

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.SecretTemplates.FieldDetail', ParameterSetName = 'Name')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Template Stub object
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Alias('TemplateId')]
        [int[]]
        $Id,

        # Fields, use New-TssSecretTemplateField to build this object
        [Parameter(Mandatory, Position = 2, ParameterSetName = 'Default')]
        [Thycotic.PowerShell.SecretTemplates.Field]
        $Field,

        [Parameter(Mandatory, ParameterSetName = 'Name')]
        [string]
        $Name,

        [Parameter(Mandatory, ParameterSetName = 'Name')]
        [string]
        $FieldSlugName,

        [Parameter(ParameterSetName = 'Name')]
        [string]
        $Description,

        [Parameter(ParameterSetName = 'Name')]
        [ValidateSet('Text', 'Notes', 'Url', 'Password', 'File', 'List', 'UrlList')]
        [string]
        $DataType
    )
    begin {
        $tssNewParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssNewParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($template in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secret-templates', $template -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                $invokeParams.Body = ($Field | ConvertTo-Json)
                if ($PSCmdlet.ParameterSetName -eq 'Name') {
                    $uri = $TssSession.ApiUrl, 'secret-templates', $template, 'fields' -join '/'
                    $invokeParams.Uri = $uri
                    $newField = @{ name = $Name; fieldSlugName = $FieldSlugName; description = [string]$Description }
                    if ($tssNewParams.ContainsKey('DataType')) { $newField.dataType = $DataType }
                    $invokeParams.Body = @{ data = $newField } | ConvertTo-Json -Depth 100
                }

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n $($invokeParams.Body)"
                if (-not $PSCmdlet.ShouldProcess("Secret Template ID: $template", "$($invokeParams.Method) $uri with $($invokeParams.Body)")) { return }
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue adding field to template [$template]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($PSCmdlet.ParameterSetName -eq 'Name') {
                    if ($restResponse) {
                        [Thycotic.PowerShell.SecretTemplates.FieldDetail](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.SecretTemplates.FieldDetail]))
                    }
                    continue
                }
                if ($restResponse -and ($restResponse.name -eq $field.Name)) {
                    Write-Verbose "Successfully added field to Secret Template [$template]"
                } else {
                    Write-Warning "Unable to add field to Secret Template [$template]"
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}