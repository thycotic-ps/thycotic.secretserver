using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.ChangeHistory
{
    public class Entry
    {
        public bool ContainsPersonalInformation { get; set; }
        public DateTime? CreateDateTime { get; set; }
        public string CreateUserDisplayName { get; set; }
        public int CreateUserId { get; set; }
        public string FieldName { get; set; }
        public bool? ValueBit { get; set; }
        public DateTime? ValueDateTime { get; set; }
        public int? ValueInt { get; set; }
        public double? ValueNumber { get; set; }
        public string ValueString { get; set; }
    }
}
