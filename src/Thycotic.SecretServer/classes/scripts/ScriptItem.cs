using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Scripts
{
    public class ScriptItem
    {
        public PSObject AdditionalData { get; set; }
        public string ConcurrencyId { get; set; }
        public string Description { get; set; }
        public bool IsActive { get; set; }
        public string Name { get; set; }
        public string Script { get; set; }
        public int ScriptCategoryId { get; set; }
        public string ScriptCategoryName { get; set; }
        public int ScriptId { get; set; }
        public string ScriptType { get; set; }
        public int UsageCount { get; set; }
    }
}
