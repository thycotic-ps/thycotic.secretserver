using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Rpc
{
    public class PasswordTypeSummary
    {
        public bool Active { get; set; }
        public bool CanEdit { get; set; }
        public bool HasCommands { get; set; }
        public int HeartbeatScriptId { get; set; }
        public bool IgnoreSsl { get; set; }
        public bool IsWeb { get; set; }
        public string Name { get; set; }
        public int PasswordTypeId { get; set; }
        public string RequiredEdition { get; set; }
        public int RpcScriptId { get; set; }
        public string RunnerType { get; set; }
        public int ScanItemTemplateId { get; set; }
        public bool UseSsl { get; set; }
    }
}