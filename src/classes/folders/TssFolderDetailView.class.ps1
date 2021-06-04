class TssFolderDetailTemplateView {
    [int]
    $Id

    [string]
    $Name
}
class TssFolderDetailView {
    [string[]]
    $Actions

    [TssFolderDetailTemplateView[]]
    $AllowedTemplates

    [string]
    $FolderWarning

    [int]
    $Id

    [string]
    $Name

    [System.String[]]
    GetActions() {
        if ($this.Actions) {
            $sortedActions = $this.Actions | Sort-Object
            return $sortedActions
        } else {
            return "No Actions found"
        }
    }

    [System.Boolean]
    TestAction([string]$Action) {
        if ($this.Actions -contains $Action) {
            return $true
        } else {
            return $false
        }
    }
}