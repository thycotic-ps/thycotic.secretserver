param(
    [Parameter(Position = 0)]
    [PSCustomObject]$Object
)
process {
    foreach ($ticketSystem in $Object.ticketSystemList) {
        [Thycotic.PowerShell.Configuration.TicketSystem]@{
            Active                                    = $ticketSystem.active.value
            AddCommentsToTicket                       = $ticketSystem.addCommentsToTicket.value
            BmcChangeManagementCommentWorkType        = $ticketSystem.bmcChangeManagementCommentWorkType.value
            BmcIncidentManagementCommentWorkType      = $ticketSystem.bmcIncidentManagementCommentWorkType.value
            BmcRemedyAuthentication                   = $ticketSystem.bmcRemedyAuthentication.value
            BmcRemedyUrlEndpoint                      = $ticketSystem.bmcRemedyUrlEndpoint.value
            Description                               = $ticketSystem.description.value
            DisplayMessage                            = $ticketSystem.displayMessage.value
            ForceRequireTicketNumber                  = $ticketSystem.forceRequireTicketNumber.value
            HideComment                               = $ticketSystem.hideComment.value
            IsDefault                                 = $ticketSystem.isDefault.value
            Name                                      = $ticketSystem.name.value
            PowerShellAddCommentScriptArguments       = $ticketSystem.powerShellAddCommentScriptArguments.value
            PowerShellAddCommentScriptId              = $ticketSystem.powerShellAddCommentScriptId.value
            PowerShellAddTicketCommentScriptArguments = $ticketSystem.powerShellAddTicketCommentScriptArguments.value
            PowerShellAddTicketCommentScriptId        = $ticketSystem.powerShellAddTicketCommentScriptId.value
            PowerShellRunAsAccountSecretId            = $ticketSystem.powerShellRunAsAccountSecretId.value
            PowerShellTicketStatusScriptArguments     = $ticketSystem.powerShellTicketStatusScriptArguments.value
            PowerShellTicketStatusScriptId            = $ticketSystem.powerShellTicketStatusScriptId.value
            ServiceNowAllowedStatuses                 = $ticketSystem.serviceNowAllowedStatuses.value
            ServiceNowDomainName                      = $ticketSystem.serviceNowDomainName.value
            SiteId                                    = $ticketSystem.siteId.value
            SystemCredentialSecretId                  = $ticketSystem.systemCredentialSecretId.value
            TicketNumberErrorMessage                  = $ticketSystem.ticketNumberErrorMessage.value
            TicketNumberValidation                    = $ticketSystem.ticketNumberValidation.value
            TicketSystemId                            = $ticketSystem.ticketSystemId.value
            TicketSystemType                          = $ticketSystem.ticketSystemType.value
            ViewTicketUrl                             = $ticketSystem.viewTicketURL.value
        }
    }
}
