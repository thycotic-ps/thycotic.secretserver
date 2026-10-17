using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DisasterRecovery
{
    public class DataReplication
    {
        public string Error { get; set; }
        public object[] Folders { get; set; }
        public string Id { get; set; }
        public bool IsFoldersBlockList { get; set; }
        public bool IsReplicating { get; set; }
        public DateTime? LastReplicated { get; set; }
        public string Location { get; set; }
        public string Name { get; set; }
        public string Status { get; set; }
    }
}
