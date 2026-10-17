using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DashboardServices
{
    public class DashboardInfo
    {
        public PSObject ConfigurationSettings { get; set; }
        public DashboardTab LastSelectedTab { get; set; }
        public DashboardWidget[] SelectedTabWidgets { get; set; }
        public DashboardTab[] Tabs { get; set; }
    }
}
