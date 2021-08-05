using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Common
{
    public class SemanticVersion
    {
        public string Version { get; set; }
        public int Major { get; set; }
        public int Minor { get; set; }
        public int Build { get; set; }
    }
}