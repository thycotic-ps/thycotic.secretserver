using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class DcmMobile
    {
        public int MobileMaxOfflineDays { get; set; }
        public int MobileMaxOfflineHours { get; set; }
    }
}
