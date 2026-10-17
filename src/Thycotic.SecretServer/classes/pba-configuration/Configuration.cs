using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.PbaConfiguration
{
    public class Configuration
    {
        public bool AllowImportData { get; set; }
        public bool ChallengeEnabled { get; set; }
        public bool ChallengeLockoutIntegratedEnabled { get; set; }
        public bool ChallengeLockoutSamlEnabled { get; set; }
        public bool Enabled { get; set; }
        public bool EncryptionEnabled { get; set; }
        public int EventDataUploadInterval { get; set; }
        public int? EventDataUploadSizeThreshold { get; set; }
        public string ExternalPbaUrl { get; set; }
        public bool FileUploadEnabled { get; set; }
        public DateTime? FirstEnabledDate { get; set; }
        public int MetadataInterval { get; set; }
        public DateTime? MetadataLastSynchronized { get; set; }
        public bool PbaIntegrationKeySet { get; set; }
        public string PbaKey { get; set; }
        public DateTime? PbaKeyCreatedDate { get; set; }
        public string PbaKeyStatus { get; set; }
        public bool RespectOwnerEditorRequireApprovalEnabled { get; set; }
        public int RetentionDays { get; set; }
        public string SecretServerKey { get; set; }
        public DateTime? SecretServerKeyCreatedDate { get; set; }
        public string SecretServerKeyStatus { get; set; }
        public int SiteId { get; set; }
        public string StorageDirectoryPath { get; set; }
        public string WarningMessage { get; set; }
    }
}
