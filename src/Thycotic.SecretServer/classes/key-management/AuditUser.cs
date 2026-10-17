using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.KeyManagement
{
    public class AuditUser
    {
        public string DisplayName { get; set; }
        public int UserId { get; set; }
    }
}
