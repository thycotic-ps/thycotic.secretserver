using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DistributedEngines
{
    public class Validation
    {
        public string Message {get;set;}
        public bool IsSuccessful {get;set;}
    }
}