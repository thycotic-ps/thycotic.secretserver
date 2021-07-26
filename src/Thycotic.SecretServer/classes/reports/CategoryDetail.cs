using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class CategoryDetail
    {
        public int ReportCategoryId { get; set; } = -1;
        public string ReportCategoryName { get; set; }
        public string ReportCategoryDescription { get; set; }
        public int SortOrder { get; set; }
    }
}