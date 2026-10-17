using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DualControls
{
    public class ApprovalGroup
    {
        public int DualControlId { get; set; }
        public bool Enabled { get; set; }
        public int GroupId { get; set; }
        public string GroupName { get; set; }
        public int Id { get; set; }
    }
}
