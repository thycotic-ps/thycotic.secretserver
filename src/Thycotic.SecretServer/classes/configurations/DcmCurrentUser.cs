using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Configuration
{
    public class DcmCurrentUser
    {
        public bool Autofill { get; set; }
        public bool AutoSubmit { get; set; }
        public bool HasTemplateRestrictions { get; set; }
        public bool InlinePopup { get; set; }
        public bool PromptToSave { get; set; }
        public bool PromptToUpdate { get; set; }
        public int[] TemplatesUserIsRestrictedTo { get; set; }
    }
}
