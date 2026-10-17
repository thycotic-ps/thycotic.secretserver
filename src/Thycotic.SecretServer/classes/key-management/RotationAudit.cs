using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.KeyManagement
{
    public class RotationAudit
    {
        public string Action { get; set; }
        public string CurrentStatus { get; set; }
        public DateTime? Date { get; set; }
        public string DisplayName { get; set; }
        public string FormattedDate { get; set; }
        public int MasterEncryptionKeyRotationInfoAuditId { get; set; }
        public int MasterEncryptionKeyRotationInfoId { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
