using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class View
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}