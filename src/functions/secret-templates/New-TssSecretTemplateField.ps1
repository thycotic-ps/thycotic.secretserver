function New-TssSecretTemplateField {
    <#
    .SYNOPSIS
    Create a new field object for the TssSecretTemplate object

    .DESCRIPTION
    Create a new field object for the TssSecretTemplate object

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    (Get-TssSecretTemplate -TssSession $session -Id 6042).Fields
    $newField = New-TssSecretTemplateField -FieldName 'Additional Field' -Searchable
    Add-TssSecretTemplateField -TssSession $session -Id 6042 -Field $newField
    (Get-TssSecretTemplate -TssSession $session -Id 6042).Fields

    Output the current fields for Secret Template 6042, create a new field named "Additional Field" that is searchable and add to the Secret Template 6042

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    $copyTemplate = Get-TssSecretTemplate -TssSession $session -Id 6042
    $copyTemplate.Name = 'Test Template - copy of 6042'
    New-TssSecretTemplate -TssSession $session -Template $copyTemplate

    Gets the Secret Template 6042, changing the name of the Template and then creating it.

    .EXAMPLE
    $session = New-TssSession 'https://alpha/SecretServer' $ssCred
    $fields = @()
    $fields += New-TssSecretTemplateField -FieldName 'Field 1 Username' -Searchable
    $fields += New-TssSecretTemplateField -FieldName 'Field 2 Password' -Type Password
    $fields += New-TssSecretTemplateField -FieldName 'Field 3 URL' -Type Url -Searchable
    New-TssSecretTemplate -TssSession $session -TemplateName 'Test Template 42' -TemplateField $fields

    Creates a new template named "Test Template 42" with 3 fields

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secret-templates/New-TssSecretTemplateStubField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secret-templates/New-TssSecretTemplateStubField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding()]
    [OutputType('Thycotic.PowerShell.SecretTemplates.Field')]
    param(
        # Field Name - value used for DisplayName, Name, and Slug Name
        [Parameter(Mandatory, Position = 0)]
        [Alias('Field')]
        [string]
        $FieldName,

        # Field Type: Notes, Text, File, Url, or Password
        [Thycotic.PowerShell.Enums.TemplateFieldTypes]
        $Type = 'Text',

        # Edit permission: Owner, Edit, NotEditable
        [string]
        $EditRequire = 'Edit',

        # Field description, defaults to null
        [string]
        $Description,

        # Field is required
        [switch]
        $IsRequired,

        # Viewing requires edit (HideOnView)
        [switch]
        $ViewRequiresEdit,

        # History length for the field, defaults to max (All)
        [int]
        $HistoryLength = [int]::MaxValue,

        # Field values are searchable (IsIndexable)
        [switch]
        $Searchable,

        # Field is exposed for display (not encrypted)
        [switch]
        $ExposeForDisplay,

        # Field order
        [int]
        $SortOrder = 0
    )
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation

        switch ($EditRequire) {
            'Owner' { $editablePermission = 3 }
            'Edit' { $editablePermission = 2 }
            'NotEditable' { $editablePermission = -1 }
        }
        switch ([string]$Type) {
            'Text' {
                $isUrl = $isPassword = $isNotes = $isFile = $false
            }
            'Notes' {
                $isUrl = $isPassword = $isFile = $false
                $isNotes = $true
            }
            'File' {
                $isUrl = $isPassword = $isNotes = $false
                $isFile = $true
            }
            'Url' {
                $isPassword = $isNotes = $isFile = $false
                $isUrl = $true
            }
            'Password' {
                $isUrl = $isNotes = $isFile = $false
                $isPassword = $true
            }
        }
        if (-not $PSBoundParameters.ContainsKey('ExposeForDisplay')) {
            [boolean]$ExposeForDisplay = $true
        }

        [Thycotic.PowerShell.SecretTemplates.Field]@{
            Description        = $Description
            DisplayName        = $FieldName
            EditablePermission = $editablePermission
            EditRequires       = $EditRequire
            FieldSlugName      = ($FieldName.Split(' ') -join '-').ToLower()
            HideOnView         = [boolean]$ViewRequiresEdit
            HistoryLength      = $HistoryLength
            IsExpirationField  = $false
            IsFile             = [boolean]$isFile
            IsIndexable        = [boolean]$Searchable
            IsNotes            = [boolean]$isNotes
            IsPassword         = [boolean]$isPassword
            IsRequired         = [boolean]$IsRequired
            IsUrl              = [boolean]$isUrl
            MustEncrypt        = [boolean]$ExposeForDisplay
            Name               = $FieldName
            SortOrder          = $SortOrder
        }
    }
}