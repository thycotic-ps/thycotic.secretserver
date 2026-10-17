using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.DualControls
{
    public class Summary
    {
        public bool Active { get; set; }
        public string DualControlTypeId { get; set; }
        public string DualControlTypeName { get; set; }
        public int Id { get; set; }
        public int? ItemId { get; set; }
        public string ItemName { get; set; }
    }
}
