class TssSecretTemplateField {
    [string]
    $Description

    [string]
    $DisplayName

    [int]
    $EditablePermission

    [ValidateSet('Edit','Owner','NotEditable')]
    [string]
    $EditRequires

    [string]
    $FieldSlugName

    [string]
    $GeneratePasswordCharacterSet

    [int]
    $GeneratePasswordLength

    [boolean]
    $HideOnView

    [int]
    $HistoryLength

    [boolean]
    $IsExpirationField

    [boolean]
    $IsFile

    [boolean]
    $IsIndexable

    [boolean]
    $IsNotes

    [boolean]
    $IsPassword

    [boolean]
    $IsRequired

    [boolean]
    $IsUrl

    [boolean]
    $MustEncrypt

    [string]
    $Name

    [int]
    $PasswordRequirementId

    [int]
    $PasswordTypeFieldId

    [int]
    $SecretTemplateFieldId

    [int]
    $SortOrder
}