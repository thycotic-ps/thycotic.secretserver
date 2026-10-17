using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.WorkflowTemplates
{
    public class Step
    {
        public StepConfiguration Configuration { get; set; }
        public int? ExpirationMinutes { get; set; }
        public string Name { get; set; }
        public int Order { get; set; }
        public int WorkflowStepTemplateId { get; set; }
        public int? WorkflowTemplateId { get; set; }
    }
}
