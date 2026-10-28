using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class SourceOu
    {
        public string DisplayName { get; set; }
        public string DistinguishedName { get; set; }
        public string Guid { get; set; }
        public int Id { get; set; }
        public string ParentGuid { get; set; }
        public string Type { get; set; }
    }
}
