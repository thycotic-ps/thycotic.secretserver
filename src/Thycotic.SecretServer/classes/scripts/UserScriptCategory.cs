using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class UserScriptCategory
    {
        public int ScriptCategoryId { get; set; }
        public string ScriptCategoryName { get; set; }
    }
}
