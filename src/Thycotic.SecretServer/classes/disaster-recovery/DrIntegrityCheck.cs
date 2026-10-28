using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DisasterRecovery
{
    public class DrIntegrityCheck
    {
        public string[] CheckedEntities { get; set; }
        public string[] Errors { get; set; }
        public bool Success { get; set; }
        public string[] Warnings { get; set; }
    }
}
