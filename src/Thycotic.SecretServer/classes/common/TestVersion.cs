using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Common
{
    public class TestVersion : SemanticVersion
    {
        public string LatestVersion { get; set; }
        public bool IsLatest { get; set; }
    }
}