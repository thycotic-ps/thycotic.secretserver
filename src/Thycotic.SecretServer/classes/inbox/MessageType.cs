using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class MessageType
    {
        public int InboxMessageTypeId { get; set; }
        public string InboxMessageTypeName { get; set; }
        public int? NotificationCount { get; set; }
    }
}
