using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Lists
{
    public class Item
    {
        public string CategorizedListItemId { get; set; }
        public Guid CategorizedListId { get; set; }
        public string Category { get; set; }
        public string Value { get; set; }
    }
}