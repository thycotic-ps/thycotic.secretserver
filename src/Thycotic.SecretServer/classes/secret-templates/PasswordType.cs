using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.SecretTemplates
{
    public class PasswordType
    {
        public int? DefaultPrivilegedSecretId { get; set; }
        public bool EnableHeartbeat { get; set; }
        public bool EnableRpc { get; set; }
        public object[] Fields { get; set; }
        public int HeartbeatIntervalDays { get; set; }
        public string HeartbeatIntervalDisplay { get; set; }
        public int HeartbeatIntervalHours { get; set; }
        public string HeartbeatIntervalLabel { get; set; }
        public int HeartbeatIntervalMinutes { get; set; }
        public string HeartbeatNote { get; set; }
        public int[] LegacyPasswordTypeIds { get; set; }
        public object[] PasswordTypeFields { get; set; }
        public int? PasswordTypeId { get; set; }
        public int RpcIntervalDays { get; set; }
        public string RpcIntervalDisplay { get; set; }
        public int RpcIntervalHours { get; set; }
        public string RpcIntervalLabel { get; set; }
        public int RpcIntervalMinutes { get; set; }
        public int? RpcMaxAttempts { get; set; }
        public string RpcNote { get; set; }
        public object[] SecretTypeFields { get; set; }
    }
}
