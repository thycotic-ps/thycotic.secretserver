using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Slack
{
    public class Configuration
    {
        public string AppId { get; set; }
        public string BotToken { get; set; }
        public bool CurrentUserHasSlackId { get; set; }
        public bool InboxNotificationsEnabled { get; set; }
        public bool SecretInteractionsEnabled { get; set; }
        public string SignatureKey { get; set; }
    }
}
