using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.WorkflowTemplates
{
    public class Instance
    {
        public string ConfigurationJson { get; set; }
        public string CurrentState { get; set; }
        public string CurrentStateInfoJson { get; set; }
        public int? CurrentStepId { get; set; }
        public string CurrentStepState { get; set; }
        public DateTime? EndTime { get; set; }
        public int EntityWorkflowMapId { get; set; }
        public DateTime? ExpirationTime { get; set; }
        public int Id { get; set; }
        public bool PendingTransaction { get; set; }
        public DateTime? StartTime { get; set; }
        public string Status { get; set; }
        public int WorkflowTemplateId { get; set; }
    }
}
