using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class Group
    {
        public string Name { get; set; }
        public Guid DsGuid { get; set; }
    }
}