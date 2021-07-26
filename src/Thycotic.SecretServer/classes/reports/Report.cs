using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class Report
    {
        public int CategoryId { get; set; }
        public string ChartType { get; set; }
        public string Description { get; set; }
        public bool Enabled { get; set; }
        public int Id { get; set; }
        public bool Is3DReport { get; set; }
        public string Name { get; set; }
        public int PageSize { get; set; }
        public string ReportSql { get; set; }
        public bool SystemReport { get; set; }
        public bool UseDatabasePaging { get; set; }
    }
}