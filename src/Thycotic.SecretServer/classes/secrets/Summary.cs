using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Secrets
{
    public class Summary
    {
        public bool Active { get; set; }
        public bool AutoChangeEnabled { get; set; }
        public bool CheckedOut { get; set; }
        public bool CheckOutEnabled { get; set; }
        public DateTime? CreateDate { get; set; }
        public int DaysUntilExpiration { get; set; }
        public bool DoubleLockEnabled { get; set; }
        public SummaryExtendedField[] ExtendedFields { get; set; }
        public int FolderId { get; set; }
        public bool HidePassword { get; set; }
        public int Id { get; set; }
        public bool InheritsPermissions { get; set; }
        public bool IsOutOfSync { get; set; }
        public string OutOfSyncReason { get; set; }
        public bool IsRestricted { get; set; }
        public DateTime? LastAccessed { get; set; }
        public SecretHeartbeatStatus LastHeartbeatStatus { get; set; }
        public DateTime? LastPasswordChangeAttempt { get; set; }
        public string Name { get; set; }
        public bool RequiresApproval { get; set; }
        public bool RequiresComment { get; set; }
        public int SecretTemplateId { get; set; }
        public string SecretTemplateName { get; set; }
        public int SiteId { get; set; }
        public string[] ResponseCodes { get; set; }
    }
}