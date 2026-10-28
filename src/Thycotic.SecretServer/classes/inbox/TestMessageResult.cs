using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class TestMessageResult
    {
        public bool EmailConfigured { get; set; }
        public bool Success { get; set; }
    }
}
