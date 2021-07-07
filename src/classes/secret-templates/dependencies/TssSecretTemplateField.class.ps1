class TssSecretTemplateField {
    [string]
    $Description

    [string]
    $DisplayName

    # -1 = NotEditable, 2 = Edit, 3 = Owner
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
    $IsList

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