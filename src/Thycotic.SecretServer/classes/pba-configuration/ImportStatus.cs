using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PbaConfiguration
{
    public class ImportStatus
    {
        public int TotalHistoricalEvents { get; set; }
        public int UnprocessedHistoricalEvents { get; set; }
    }
}
