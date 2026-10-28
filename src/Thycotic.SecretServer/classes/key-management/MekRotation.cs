using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.KeyManagement
{
    public class MekRotation
    {
        public bool CanRequestRotation { get; set; }
        public bool CanRetryStatus { get; set; }
        public string ErrorMessage { get; set; }
        public bool HasPermission { get; set; }
        public bool IsReplicationEnabled { get; set; }
        public int ItemsToRotate { get; set; }
        public bool PollInfo { get; set; }
        public string ProcessState { get; set; }
        public PSObject RotationInfo { get; set; }
        public bool ShowBackupConfirmation { get; set; }
        public int TotalItems { get; set; }
        public string WarningMessage { get; set; }
    }
}
