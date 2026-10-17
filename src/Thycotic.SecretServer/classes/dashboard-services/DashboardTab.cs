using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DashboardServices
{
    public class DashboardTab
    {
        public string HashParameters { get; set; }
        public int Id { get; set; }
        public string TabName { get; set; }
        public int TabType { get; set; }
    }
}
