using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCommand
{
    public class SshCommand
    {
        public string Command { get; set; }
        public string CommandPermissionType { get; set; }
        public string Name { get; set; }
        public int? SortOrder { get; set; }
        public string SshCommandGuid { get; set; }
        public int SshCommandId { get; set; }
    }
}
