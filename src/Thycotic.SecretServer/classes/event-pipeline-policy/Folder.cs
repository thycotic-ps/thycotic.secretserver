using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.EventPipelinePolicy
{
    public class Folder
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Path { get; set; }
        public bool Restricted { get; set; }
    }
}
