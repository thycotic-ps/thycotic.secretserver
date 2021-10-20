using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Lists
{
    public class Summary
    {
        public bool Active { get; set; }
        public string CategorizedListId { get; set; }
        public string Description { get; set; }
        public string Name { get; set; }
        public int NumOptions { get; set; }
    }
}