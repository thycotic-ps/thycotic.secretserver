using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class Dcm
    {
        public bool Autofill { get; set; }
        public bool AutoSubmit { get; set; }
        public int[] AvailableTemplatesFilter { get; set; }
        public int[] CustomTemplateIds { get; set; }
        public bool InlinePopup { get; set; }
        public bool PromptToSave { get; set; }
        public bool PromptToUpdate { get; set; }
        public string TemplateConfiguration { get; set; }
        public string Type { get; set; }
    }
}
