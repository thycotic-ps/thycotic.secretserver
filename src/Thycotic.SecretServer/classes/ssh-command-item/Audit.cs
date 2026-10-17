using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SshCommandItem
{
    public class Audit
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string ItemName { get; set; }
        public string ItemType { get; set; }
        public string NewCommands { get; set; }
        public string Notes { get; set; }
        public string OldCommands { get; set; }
        public string UserDisplayName { get; set; }
    }
}
