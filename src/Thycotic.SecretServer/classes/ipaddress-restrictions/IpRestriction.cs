using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.IpRestrictions
{
    public class IpRestriction
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Range { get; set; }
    }
}