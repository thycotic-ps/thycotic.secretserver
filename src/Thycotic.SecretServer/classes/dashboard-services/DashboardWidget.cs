using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DashboardServices
{
    public class DashboardWidget
    {
        public string ControlName { get; set; }
        public string DisplayName { get; set; }
        public int Id { get; set; }
        public string State { get; set; }
        public int TabWidgetId { get; set; }
        public int XIndex { get; set; }
        public int YIndex { get; set; }
    }
}
