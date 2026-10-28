using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.BulkOperations
{
    public class Progress
    {
        public object[] Errors { get; set; }
        public string Identifier { get; set; }
        public bool IsComplete { get; set; }
        public PSObject KbLink { get; set; }
        public int PercentageComplete { get; set; }
        public string StatusMessage { get; set; }
    }
}
