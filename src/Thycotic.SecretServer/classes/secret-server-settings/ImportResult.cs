using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretServerSettings
{
    public class ImportResult
    {
        public PSObject Errors { get; set; }
        public PSObject SecretServerSettings { get; set; }
        public PSObject Warnings { get; set; }
    }
}
