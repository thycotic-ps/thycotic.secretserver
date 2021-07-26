using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.WorkflowTemplates
{
    public class Detail
    {
        public bool Active { get; set; }
        public string ConfigurationJson { get; set; }
        public string Description { get; set; }
        public int ExpirationMinutes { get; set; }
        public string Name { get; set; }
        public bool Reusable { get; set; }
        public string TypeName { get; set; }
        public int WorkflowTemplateId { get; set; }
        public string WorkflowType { get; set; }
    }
}