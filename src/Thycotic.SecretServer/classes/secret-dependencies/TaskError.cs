using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretDependencies
{
    public class TaskError
    {
        public string ErrorMessage { get; set; }
        public string ItemName { get; set; }
    }
}