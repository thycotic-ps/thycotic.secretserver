using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum SecretStates
    {
        None,
        RequiresApproval,
        RequiresCheckout,
        RequiresComment,
        RequiresDoubleLockPassword,
        CreateDoubleLockPassword,
        DoubleLockNoAccess,
        CannotView,
        RequiresUndelete,
        RequiresCheckoutPendingRPC,
        RequiresCheckoutAndComment
    }
}