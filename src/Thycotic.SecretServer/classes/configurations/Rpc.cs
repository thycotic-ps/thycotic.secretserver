using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Rpc
    {
        public int CheckOutIntervalDays { get; set; }
        public int CheckOutIntervalHours { get; set; }
        public int CheckOutIntervalMinutes { get; set; }
        public int DaysToKeepLogs { get; set; }
        public bool EnableHeartbeat { get; set; }
        public bool EnablePasswordChangeOnCheckIn { get; set; }
        public bool EnableRpc { get; set; }
    }
}