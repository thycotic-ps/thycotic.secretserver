using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.General
{
    public class VersionSummary
    {
        public bool IsLatest { get; set; }
        public string LatestVersion { get; set; }
        public string Version { get; set; }
    }
}