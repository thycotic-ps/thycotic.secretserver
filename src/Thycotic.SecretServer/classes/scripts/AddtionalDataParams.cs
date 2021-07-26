using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class AdditionalDataParams
    {
        public string Name { get; set; }
        public int SshType { get; set; }
    }
}