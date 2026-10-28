using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Secrets
{
    public class DetailGeneral
    {
        public bool Active { get; set; }
        public int AllowedDays { get; set; }
        public bool AutoChangePassword { get; set; }
        public bool CanGenerateSshKey { get; set; }
        public bool EnableDependencyPreRunValidation { get; set; }
        public bool EnableInheritSecretPolicy { get; set; }
        public string Expiration { get; set; }
        public string[] Fields { get; set; }
        public int? Folder { get; set; }
        public string GenerateSshKeyLabel { get; set; }
        public bool HeartbeatEnabled { get; set; }
        public int IconId { get; set; }
        public string IconName { get; set; }
        public int Id { get; set; }
        public bool IsFavorite { get; set; }
        public bool IsOutOfSync { get; set; }
        public bool IsTotpEnabled { get; set; }
        public DateTime? LastHeartBeatCheck { get; set; }
        public string LastHeartBeatStatus { get; set; }
        public object[] Launchers { get; set; }
        public string Name { get; set; }
        public string OutOfSyncReason { get; set; }
        public string PasswordCompliance { get; set; }
        public int? SecretPolicy { get; set; }
        public int? Site { get; set; }
        public string SlugPrivateKey { get; set; }
        public string SlugPublicKey { get; set; }
        public int? Template { get; set; }
        public string TotpPasswordSlug { get; set; }
    }
}
