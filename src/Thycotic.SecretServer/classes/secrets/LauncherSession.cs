using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class LauncherSession
    {
        public bool Active { get; set; }
        public DateTime? EndDate { get; set; }
        public int? LauncherTypeId { get; set; }
        public int SecretId { get; set; }
        public int? SecretSessionId { get; set; }
        public DateTime? StartDate { get; set; }
        public string UserName { get; set; }
    }
}
