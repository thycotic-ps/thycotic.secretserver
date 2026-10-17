using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.FeatureFlag
{
    public class State
    {
        public string Key { get; set; }
        public bool Enabled { get; set; }
    }
}
