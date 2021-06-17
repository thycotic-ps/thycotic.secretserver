class TssSecretTemplate {
    [int]
    $Id

    [string]
    $Name

    [int]
    $PasswordTypeId

    [TssSecretTemplateField[]]
    $Fields

    [System.String]
    GetSlugName([string]$DisplayName) {
        $slugName = $this.Fields.Where( { $_.DisplayName -eq $DisplayName }).FieldSlugName
        return $slugName
    }

    [TssSecretTemplateField]
    GetField([string]$SlugName) {
        $field = $this.Fields | Where-Object FieldSlugName -eq $SlugName
        return [TssSecretTemplateField]$field
    }
}