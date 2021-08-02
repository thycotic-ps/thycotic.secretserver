using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Enums
{
    public enum EventEntityType
    {
        Unknown = 0,
        User = 1,
        Folder = 2,
        Role = 3,
        RolePermission = 4,
        Configuration = 5,
        Group = 6,
        IpAddressRange = 7,
        Secret = 10001,
        UnlimitedAdmin = 10002,
        ExportSecrets = 10003,
        ImportSecrets = 10004,
        UserAudit = 10005,
        SecretTemplate = 10006,
        Licenses = 10007,
        ScriptPowerShell = 10008,
        SecretPolicy = 10009,
        ScriptSsh = 10010,
        ScriptSsql = 10011,
        Encryption = 10012,
        Site = 10013,
        Engine = 10014,
        SiteConnector = 10015,
        SecurityAnalyticsConfiguration = 10016,
        DualControl = 10017,
        Tls = 10018,
        PasswordChanger = 10019,
        CharacterSet = 10020,
        PasswordRequirement = 10021,
        Domain = 10022,
        BackupConfiguration = 10023,
        SecretServerSettings = 10024,
        AutoExport = 10025
    }
}