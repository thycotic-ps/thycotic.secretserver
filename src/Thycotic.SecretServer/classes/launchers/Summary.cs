using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Launchers
{
    public class Summary
    {
        public bool Active { get; set; }
        public string Application { get; set; }
        public int Id { get; set; }
        public bool IsCustom { get; set; }
        public string Name { get; set; }
    }
}
