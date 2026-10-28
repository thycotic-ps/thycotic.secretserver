using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class SecretActivityExpireResult
    {
        public bool Success { get; set; }
        public string BulkOperationId { get; set; }
    }
}
