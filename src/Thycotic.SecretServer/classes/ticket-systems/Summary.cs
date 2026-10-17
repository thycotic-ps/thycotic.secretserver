using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.TicketSystems
{
    public class Summary
    {
        public bool Active { get; set; }
        public string Description { get; set; }
        public string DisplayMessage { get; set; }
        public string EnableTicketOverride { get; set; }
        public int ForceRequireTicketNumber { get; set; }
        public bool HideComment { get; set; }
        public bool IsDefault { get; set; }
        public string Name { get; set; }
        public int? SiteId { get; set; }
        public string SiteName { get; set; }
        public int TicketOverrideDurationMinutes { get; set; }
        public bool TicketOverrideSecretOwners { get; set; }
        public int TicketSystemId { get; set; }
        public int TicketSystemTypeId { get; set; }
        public string TicketSystemTypeName { get; set; }
        public string ViewTicketUrl { get; set; }
    }
}
