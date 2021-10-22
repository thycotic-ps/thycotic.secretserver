using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Lists
{
    public class Category
    {
        public string CategorizedListId { get; set; }
        public string CategoryName { get; set; }
    }
}