using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class ListItem
    {
        public bool CanCreate { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
