using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum SecretPolicyItem
    {
        AutoChangeOnExpiration = 1,
        HeartBeatEnabled = 2,
        SiteId = 3,
        PrivilegedSecretId = 4,
        PriveledgedSecretId = 4,
        AssociatedSecretId1 = 5,
        AutoChangeSchedule = 6,
        PasswordTypeWebScriptId = 7,
        CheckOutEnabled = 8,
        CheckOutIntervalMinutes = 9,
        CheckOutChangePassword = 10,
        RequireApprovalForAccess = 11,
        RequireApprovalForAccessForOwnersAndApprovers = 12,
        RequireApprovalForAccessForEditors = 13,
        RequireViewComment = 14,
        IsSessionRecordingEnabled = 15,
        ViewingPasswordRequiresEdit = 16,
        ApprovalGroup = 17,
        AssociatedSecretId2 = 18,
        IsProxyEnabled = 19,
        EnableSshCommandRestrictions = 20,
        SshCommandMenuGroups = 21,
        AllowOwnersUnrestrictedSshCommands = 22,
        ApprovalWorkflow = 23,
        EventPipelinePolicy = 24,
        RunLauncherUsingSSHKey = 25,
        WebLauncherRequiresIncognitoMode = 26,
        SshCommandRestrictionType = 27,
        SshCommandBlocklistOwners = 28,
        SshCommandBlocklistEditors = 29,
        SshCommandBlocklistViewers = 30,
    }
}