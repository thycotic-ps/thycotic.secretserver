using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum ScriptCategory
    {
        Untyped = 1,
        TicketValidation = 2,
        TicketComment = 3,
        SecretDiscovery = 4,
        Heartbeat = 5,
        PasswordChanging = 6,
        DiscoveryTakeover = 7,
        Dependency = 8
    }
}