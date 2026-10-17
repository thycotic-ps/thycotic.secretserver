using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DualControls
{
    public class DualControl
    {
        public bool Active { get; set; }
        public ApprovalGroup[] DualControlApprovalGroups { get; set; }
        public int DualControlTypeId { get; set; }
        public string DualControlTypeName { get; set; }
        public int Id { get; set; }
        public int? ItemId { get; set; }
        public string ItemName { get; set; }
    }
}
