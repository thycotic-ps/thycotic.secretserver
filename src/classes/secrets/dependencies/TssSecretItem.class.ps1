class TssSecretItem {
    [string]$FieldDescription
    [int]$FieldId
    [string]$FieldName
    [int]$FileAttachmentId
    [string]$Filename
    [boolean]$IsFile
    [boolean]$IsNotes
    [boolean]$IsPassword
    [int]$ItemId
    [string]$ItemValue
    [string]$Slug

    [boolean] SetFieldValue([string]$Slug,$Value) {
        if ($this.Slug -eq $Slug) {
            $this.ItemValue = $Value
        }
        return $true
    }
}