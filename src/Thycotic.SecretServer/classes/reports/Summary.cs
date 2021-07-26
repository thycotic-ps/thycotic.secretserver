using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Reports
{
    public class Summary
    {
        public int CategoryId { get; set; }
        public bool Enabled { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
