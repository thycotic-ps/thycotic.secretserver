using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class TemplateConversion
    {
        public int? SecretId { get; set; }
        public string TaskId { get; set; }
    }
}
