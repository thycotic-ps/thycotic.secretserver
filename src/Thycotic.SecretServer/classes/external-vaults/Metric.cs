using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class Metric
    {
        public int TotalExternalSecrets { get; set; }
    }
}
