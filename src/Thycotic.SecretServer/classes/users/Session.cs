using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class Session
    {
        public string Browser { get; set; }
        public bool Current { get; set; }
        public string IpAddress { get; set; }
        public DateTime? LoginDate { get; set; }
        public int UserSessionId { get; set; }
    }
}
