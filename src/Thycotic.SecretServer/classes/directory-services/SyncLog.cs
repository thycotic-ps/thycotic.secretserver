using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DirectoryServices
{
    public class SyncLog
    {
        public DateTime? CreatedOn { get; set; }
        public string MachineName { get; set; }
        public string Text { get; set; }
    }
}
