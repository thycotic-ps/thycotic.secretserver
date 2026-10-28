using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class DataName
    {
        public int CreatedByUserId { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int InboxDataId { get; set; }
        public string InboxDataName { get; set; }
    }
}
