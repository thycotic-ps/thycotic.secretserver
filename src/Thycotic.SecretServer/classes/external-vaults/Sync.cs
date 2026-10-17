using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ExternalVaults
{
    public class Sync
    {
        public object[] PullResults { get; set; }
        public object[] PushResults { get; set; }
    }
}
