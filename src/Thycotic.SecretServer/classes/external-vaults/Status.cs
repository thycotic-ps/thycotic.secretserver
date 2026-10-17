using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class Status
    {
        public bool CreateSecret { get; set; }
        public int TotalVaults { get; set; }
    }
}
