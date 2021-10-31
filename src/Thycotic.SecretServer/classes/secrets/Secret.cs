using System;
using System.Security;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using Thycotic.PowerShell.Enums;

namespace Thycotic.PowerShell.Secrets
{
    public class Secret
    {
        public int AccessRequestWorkflowMapId { get; set; }
        public bool Active { get; set; }
        public bool AllowOwnersUnrestrictedSshCommands { get; set; }
        public bool AutoChangeEnabled { get; set; }
        public string AutoChangeNextPassword { get; set; }
        public bool CheckedOut { get; set; }
        public bool CheckOutChangePasswordEnabled { get; set; }
        public bool CheckOutEnabled { get; set; }
        public int CheckOutIntervalMinutes { get; set; }
        public int CheckOutMinutesRemaining { get; set; }
        public string CheckOutUserDisplayName { get; set; }
        public int CheckOutUserId { get; set; }
        public int DoubleLockId { get; set; }
        public bool EnableInheritPermissions { get; set; }
        public bool EnableInheritSecretPolicy { get; set; }
        public int FailedPasswordChangeAttempts { get; set; }
        public int FolderId { get; set; }
        public int Id { get; set; }
        public bool IsDoubleLock { get; set; }
        public bool IsOutOfSync { get; set; }
        public bool IsRestricted { get; set; }
        public Items[] Items { get; set; }
        public DateTime? LastHeartBeatCheck { get; set; }
        public SecretHeartbeatStatus LastHeartBeatStatus { get; set; }
        public DateTime? LastPasswordChangeAttempt { get; set; }
        public int LauncherConnectAsSecretId { get; set; }
        public string Name { get; set; }
        public string OutOfSyncReason { get; set; }
        public int PasswordTypeWebScriptId { get; set; }
        public bool ProxyEnabled { get; set; }
        public bool RequiresApprovalForAccess { get; set; }
        public bool RequiresComment { get; set; }
        public bool RestrictSshCommands { get; set; }
        public int SecretPolicyId { get; set; }
        public int SecretTemplateId { get; set; }
        public string SecretTemplateName { get; set; }
        public bool SessionRecordingEnabled { get; set; }
        public int SiteId { get; set; }
        public bool WebLauncherRequiresIncognitoMode { get; set; }
        public string[] ResponseCodes { get; set; }

        public PSCredential GetCredential(string DomainField, string UserField, string PasswordField)
        {
            string domainValue = "";
            string usernameValue = "";
            SecureString securePwd = new SecureString();
            foreach (var item in this.Items)
            {
                if (item.Slug.Equals(DomainField, StringComparison.OrdinalIgnoreCase))
                {
                    domainValue = item.ItemValue;
                }
                if (item.Slug.Equals(UserField, StringComparison.OrdinalIgnoreCase))
                {
                    usernameValue = item.ItemValue;
                }
                if (item.Slug.Equals(PasswordField, StringComparison.OrdinalIgnoreCase))
                {
                    foreach (char c in item.ItemValue.ToCharArray())
                    {
                        securePwd.AppendChar(c);
                    }
                }
            }

            //create username as domain\username
            string domainUser = "";
            if (string.IsNullOrEmpty(domainValue.ToString()))
            {
                domainUser = usernameValue.ToString();
            }
            else
            {
                domainUser = string.Format("{0}\\{1}", domainValue, usernameValue);
            }

            //create PSCredential
            var credential = new PSCredential(domainUser, securePwd);
            return credential;
        }

        public string GetFieldValue(string SlugName)
        {
            string value = null;
            foreach (var item in this.Items)
            {
                if (item.Slug.Equals(SlugName, StringComparison.OrdinalIgnoreCase))
                {
                    value = item.ItemValue;
                }
            }
            return value;
        }

        public void SetFieldValue(string SlugName, string NewValue)
        {
            foreach (var item in this.Items)
            {
                if (item.Slug.Equals(SlugName, StringComparison.OrdinalIgnoreCase))
                {
                    item.ItemValue = NewValue;
                    break;
                }
            }
        }

        public void UpdateFieldId(string SlugName, int OrginalId, int NewId)
        {
            foreach (var item in this.Items)
            {
                if (item.Slug.Equals(SlugName) && item.FieldId.Equals(OrginalId))
                {
                    item.FieldId = NewId;
                    break;
                }
            }
        }

        public List<FileField> GetFileFields()
        {
            List<FileField> files = new List<FileField>();
            foreach (var item in this.Items)
            {
                if (item.IsFile)
                {
                    files.Add(new FileField { SlugName = item.Slug, Filename = item.Filename });
                }
            }
            return files;
        }
        public class FileField
        {
            public string SlugName { get; set; }
            public string Filename { get; set; }
        }
    }
}
