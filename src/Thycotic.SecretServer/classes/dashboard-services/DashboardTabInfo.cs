using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DashboardServices
{
    public class DashboardTabInfo
    {
        public DashboardTab Tab { get; set; }
        public DashboardWidget[] TabWidgets { get; set; }
    }
}
