using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class AdditionalData
    {
        public int Port { get; set; }
        public int LineEnding { get; set; }
        public AdditionalDataParams[] Params { get; set; }
        public bool DoNotUseEnvironment { get; set; }
        public int Version { get; set; }
    }
}
