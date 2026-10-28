using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Platform
{
    public class UserMappingResult
    {
        public string Message { get; set; }
        public bool Success { get; set; }
    }
}
