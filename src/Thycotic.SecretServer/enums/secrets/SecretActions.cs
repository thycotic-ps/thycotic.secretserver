using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum SecretActions
    {
        ChangePasswordNow,
        ConvertTemplate,
        Copy,
        Delete,
        Edit,
        EditExpiration,
        EditRpc,
        EditSecurity,
        Expire,
        Heartbeat,
        EditShare,
        ShowSshProxyCredentials,
        StopChangePasswordNow,
        ViewAudit,
        ViewDependencies,
        ViewLaunchers,
        ViewExpiration,
        ViewHooks,
        ViewRpc,
        ViewSecurity,
        ViewSettings,
        Undelete,
        ForceCheckIn,
        ViewShare,
        EditHooks,
        EditDependencies,
        ViewGeneralDetails,
        ViewHeartbeatStatus,
        CheckIn,
        Checkout,
        GenerateOneTimePassword,
        ShowSshTerminalDetails,
        ShowRdpProxyCredentials,
        ViewMetadata
    }
}