using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class Export
    {
        public string ExportFileText { get; set; }
        public string FileName { get; set; }
    }
}
