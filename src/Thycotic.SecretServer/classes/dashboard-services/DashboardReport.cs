using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DashboardServices
{
    public class DashboardReport
    {
        public bool HasChart { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public string ReportCategoryName { get; set; }
    }
}
