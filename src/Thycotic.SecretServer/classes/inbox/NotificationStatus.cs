using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Inbox
{
    public class NotificationStatus
    {
        public int? ApplicationRequestPendingTotal { get; set; }
        public bool HasAlerts { get; set; }
        public int? InboxNotificationTotal { get; set; }
        public DateTime? NotificationsLastViewed { get; set; }
        public int? SecretAccessRequestPendingTotal { get; set; }
        public int? SecretEraseRequestPendingTotal { get; set; }
        public int? SystemAlertTotal { get; set; }
    }
}
