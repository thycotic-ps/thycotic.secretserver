using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class Notification
    {
        public string Action { get; set; }
        public DateTime? AlertDate { get; set; }
        public string Description { get; set; }
        public bool IsRead { get; set; }
        public string Name { get; set; }
        public string NotificationId { get; set; }
        public string NotificationType { get; set; }
        public string Type { get; set; }
    }
}
