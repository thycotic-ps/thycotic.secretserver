using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class TemplateResource
    {
        public string ImageData { get; set; }
        public string ImageType { get; set; }
        public int InboxResourceId { get; set; }
        public string Name { get; set; }
    }
}
