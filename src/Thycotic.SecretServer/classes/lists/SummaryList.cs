using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Lists
{
    public class SummaryList
    {
        public Guid CategorizedListId { get; set; }
        public string Name { get; set;}
    }
}