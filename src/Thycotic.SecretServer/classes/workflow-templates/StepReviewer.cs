using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.WorkflowTemplates
{
    public class StepReviewer
    {
        public int AccessReviewerId { get; set; }
        public string DisplayName { get; set; }
        public int? GroupId { get; set; }
        public bool IsOwner { get; set; }
        public bool? IsUser { get; set; }
        public int WorkflowStepTemplateId { get; set; }
        public int? WorkflowTemplateId { get; set; }
    }
}
