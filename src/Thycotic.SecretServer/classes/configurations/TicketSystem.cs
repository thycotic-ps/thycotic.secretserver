using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class TicketSystem
    {
        public bool Active { get; set; }
        public bool AddCommentsToTicket { get; set; }
        public string BmcChangeManagementCommentWorkType { get; set; }
        public string BmcIncidentManagementCommentWorkType { get; set; }
        public string BmcRemedyAuthentication { get; set; }
        public string BmcRemedyUrlEndpoint { get; set; }
        public string Description { get; set; }
        public string DisplayMessage { get; set; }
        public string ForceRequireTicketNumber { get; set; }
        public bool HideComment { get; set; }
        public bool IsDefault { get; set; }
        public string Name { get; set; }
        public string PowerShellAddCommentScriptArguments { get; set; }
        public int? PowerShellAddCommentScriptId { get; set; }
        public string PowerShellAddTicketCommentScriptArguments { get; set; }
        public int? PowerShellAddTicketCommentScriptId { get; set; }
        public int? PowerShellRunAsAccountSecretId { get; set; }
        public string PowerShellTicketStatusScriptArguments { get; set; }
        public int? PowerShellTicketStatusScriptId { get; set; }
        public string ServiceNowAllowedStatuses { get; set; }
        public string ServiceNowDomainName { get; set; }
        public int? SiteId { get; set; }
        public int? SystemCredentialSecretId { get; set; }
        public string TicketNumberErrorMessage { get; set; }
        public string TicketNumberValidation { get; set; }
        public int TicketSystemId { get; set; }
        public string TicketSystemType { get; set; }
        public string ViewTicketUrl { get; set; }
    }
}
