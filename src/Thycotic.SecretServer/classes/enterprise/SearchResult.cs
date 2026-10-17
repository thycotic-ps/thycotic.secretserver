using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enterprise
{
    public class SearchResult
    {
        public object[] Data { get; set; }
        public DateTime? ProcessEndDate { get; set; }
        public DateTime? ProcessStartDate { get; set; }
    }
}
