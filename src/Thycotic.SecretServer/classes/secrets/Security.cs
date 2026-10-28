using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class Security
    {
        public bool AllowOwnersUnrestrictedSshCommands { get; set; }
        public PSObject ApprovalWorkflow { get; set; }
        public object[] Approvers { get; set; }
        public bool BypassProxyForPraLaunches { get; set; }
        public bool CheckOutChangePasswordEnabled { get; set; }
        public string CheckOutDefaultIntervalDisplay { get; set; }
        public bool CheckOutEnabled { get; set; }
        public string CheckOutIntervalDisplay { get; set; }
        public int? CheckOutIntervalMinutes { get; set; }
        public string CommandRestrictionType { get; set; }
        public int DoubleLockId { get; set; }
        public string DoubleLockName { get; set; }
        public bool HideLauncherPassword { get; set; }
        public bool IsDoubleLock { get; set; }
        public bool IsMultiFactorAuthenticationRequired { get; set; }
        public PSObject PasswordRequirements { get; set; }
        public bool ProxyEnabled { get; set; }
        public string RequireApprovalType { get; set; }
        public bool RequiresComment { get; set; }
        public int RestrictedSshCommandCount { get; set; }
        public bool RestrictSshCommands { get; set; }
        public bool SessionRecordingEnabled { get; set; }
        public bool SharedWithDelineaPlatform { get; set; }
        public bool ShouldDisplayMultifactorAuthenticationDisasterRecoveryWarning { get; set; }
    }
}
