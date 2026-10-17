using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class Message
    {
        public object[] Data { get; set; }
        public string Details { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public int InboxMessageTypeId { get; set; }
        public string InboxMessageTypeName { get; set; }
        public bool IsRead { get; set; }
        public DateTime? MessageCreatedDate { get; set; }
        public int MessageId { get; set; }
        public string[] Recipients { get; set; }
    }
}
