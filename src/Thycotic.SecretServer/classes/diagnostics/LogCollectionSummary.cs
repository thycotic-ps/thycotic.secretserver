using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Diagnostics
{
    public class LogCollectionSummary
    {
        public LogCollectionItem[] LogCollection { get; set; }
        public DateTime? StartDate { get; set; }
    }
}
