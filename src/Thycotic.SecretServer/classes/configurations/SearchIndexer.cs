using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Configuration
{
    public class SearchIndexer
    {
        public int DaysToKeepLogs { get; set; }
        public bool Enabled { get; set; }
        public string[] IndexingSeparators { get; set; }
        public SearchIndexMode IndexMode { get; set; }
        public float IndexPercentComplete { get; set; }
        public DateTime? LastIndexDate { get; set; }
        public bool LogAvailable { get; set; }
        public SearchIndexStatus Status { get; set; }
    }
}