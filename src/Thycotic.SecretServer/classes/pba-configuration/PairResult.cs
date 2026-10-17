using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PbaConfiguration
{
    public class PairResult
    {
        public bool AlreadyApproved { get; set; }
        public bool Success { get; set; }
    }
}
