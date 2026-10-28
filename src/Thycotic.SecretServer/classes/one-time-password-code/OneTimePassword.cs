using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.OneTimePasswordCode
{
    public class OneTimePassword
    {
        public string Code { get; set; }
        public int DurationSeconds { get; set; }
        public int RemainingSeconds { get; set; }
    }
}
