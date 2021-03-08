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
}