class TssSecretDetailState {
    [string[]]
    $Actions

    [string]
    $CheckedOutUserDisplayName

    [int]
    $CheckedOutUserId

    [int]
    $CheckOutIntervalMinutes

    [int]
    $CheckOutMinutesRemaining

    [int]
    $FolderId

    [string]
    $FolderName

    [int]
    $Id

    [boolean]
    $IsActive

    [boolean]
    $IsCheckedOut

    [boolean]
    $IsCheckedOutByCurrentUser

    [boolean]
    $PasswordChangePending

    [string]
    $Role

    [string]
    $SecretName

    [ValidateSet('None','RequiresApproval','RequiresCheckout','RequiresComment','RequiresDoubleLockPassword','CreateDoubleLockPassword','DoubleLockNoAccess','CannotView','RequiresUndelete','RequiresCheckoutPendingRPC','RequiresCheckoutAndComment')]
    [string]
    $SecretState

    [System.String[]] GetActions() {
        if ($this.Actions) {
            $sortedActions = $this.Actions | Sort-Object
            return $sortedActions
        } else {
            return "No Actions found"
        }
    }
}