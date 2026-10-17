using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class HealthExposure
    {
        public bool CanView { get; set; }
        public string DisplayName { get; set; }
        public string DisplayNameAndUserName { get; set; }
        public string Domain { get; set; }
        public bool Enabled { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
