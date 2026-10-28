using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Users
{
    public class TotpStatus
    {
        public string Account { get; set; }
        public string Key { get; set; }
        public string Url { get; set; }
    }
}
