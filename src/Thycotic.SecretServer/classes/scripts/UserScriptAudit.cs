using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class UserScriptAudit
    {
        public string Action { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string IpAddress { get; set; }
        public string Notes { get; set; }
        public int? ScriptHistoryId { get; set; }
        public int ScriptId { get; set; }
        public string ScriptName { get; set; }
        public string User { get; set; }
        public int UserId { get; set; }
    }
}
