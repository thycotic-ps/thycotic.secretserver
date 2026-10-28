using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class NetworkTree
    {
        public bool HasChildren { get; set; }
        public int Id { get; set; }
        public string Name { get; set; }
        public int ParentId { get; set; }
    }
}
