using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class TemplateLocale
    {
        public int LocaleCultureId { get; set; }
        public string Subject { get; set; }
        public string TemplateBody { get; set; }
        public int TemplateId { get; set; }
        public int TemplateLocaleId { get; set; }
    }
}
