using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PbaConfiguration
{
    public class HistoryImport
    {
        public int? NumberOfEventsProcessed { get; set; }
        public bool Success { get; set; }
    }
}
