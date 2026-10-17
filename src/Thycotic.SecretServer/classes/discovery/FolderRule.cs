using System;
using System.Threading.Tasks;
using System.Management.Automation;
using System.Management.Automation.Runspaces;

namespace Thycotic.PowerShell.Discovery
{
    public class FolderRule
    {
        public int RuleId { get; set; }
        public string RuleName { get; set; }
    }
}
