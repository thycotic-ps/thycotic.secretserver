using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.WorkflowTemplates
{
    public class StepConfiguration
    {
        public StepReviewer[] ApproverGroups { get; set; }
        public int ApproveStep { get; set; }
        public int ExpireStep { get; set; }
        public int NumApprovalsRequired { get; set; }
    }
}
