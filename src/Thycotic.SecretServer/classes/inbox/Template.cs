using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class Template
    {
        public bool IsSystem { get; set; }
        public int Locale { get; set; }
        public int TemplateId { get; set; }
        public string TemplateName { get; set; }
        public string TemplateType { get; set; }
    }
}
