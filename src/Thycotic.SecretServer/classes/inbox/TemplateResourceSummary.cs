using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class TemplateResourceSummary
    {
        public int InboxResourceId { get; set; }
        public string InboxResourceSlug { get; set; }
        public string InboxResourceType { get; set; }
    }
}
