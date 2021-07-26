using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class TaskProgress
    {
        public TaskError[] Errors { get; set; }
        public bool IsComplete { get; set; }
        public int PercentageComplete { get; set; }
        public string Status { get; set; }
        public string TaskIdentifier { get; set; }
    }
}