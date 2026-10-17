using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PlatformMigration
{
    public class PreCheckSummary
    {
        public int ErrorCount { get; set; }
        public object[] Errors { get; set; }
        public bool HasEmptyGroupTypeErrors { get; set; }
        public int InformationCount { get; set; }
        public int WarningCount { get; set; }
    }
}
