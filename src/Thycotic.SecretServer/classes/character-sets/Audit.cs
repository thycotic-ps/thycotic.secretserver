using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.CharacterSets
{
    public class Audit
    {
        public string Action { get; set; }
        public int CharacterSetAuditId { get; set; }
        public int CharacterSetId { get; set; }
        public DateTime? DateRecorded { get; set; }
        public string DisplayName { get; set; }
        public string Notes { get; set; }
        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}
