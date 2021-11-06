using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Lists
{
    public class List
    {
        public bool Active { get; set; }
        public Guid CategorizedListId { get; set; }
        public string Description { get; set; }
        public Item[] Items { get; set; }
        public string Name { get; set; }
    }
}